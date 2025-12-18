import asyncio
from asyncio import CancelledError
import logging
import json
import yaml
from amqtt.broker import Broker
from amqtt.client import MQTTClient
from passlib.hash import sha512_crypt
import os


# Default user credentials for test server
USER = ["test_user"]
PASSWORDS = ["test_password"]
PASSWORD_PATH = "passwords.txt"


#Writes encrypted passwords into the passwords file
def write_passwords():
    # clear old password file
    open(PASSWORD_PATH, 'w').close()

    for i in range(len(USER)):
        pw = sha512_crypt.hash(PASSWORDS[i])
        line = USER[i] + ":" + pw
        with open(PASSWORD_PATH, "a") as f:
            f.write(line + "\n")


formatter = "[%(asctime)s] :: %(levelname)s :: %(name)s :: %(message)s"
logging.basicConfig(level=logging.INFO, format=formatter)
CONFIG_FILE = "broker_config.yaml"


if not os.path.exists(CONFIG_FILE):
    raise SystemExit(f"Missing {CONFIG_FILE} in working dir: {os.getcwd()}")

with open(CONFIG_FILE, "r") as f:
    config = yaml.safe_load(f)


#Starts the server
async def run_server() -> None:
    broker = Broker(config=config)
    try:
        await broker.start()
        # start an internal test client to publish sample commands and
        # log responses so the scanner can be tested end-to-end
        asyncio.create_task(_run_test_client())
        while True:
            await asyncio.sleep(1)
    except CancelledError:
        await broker.shutdown()


async def _run_test_client():
    # helper to connect to the local broker and publish test messages
    # locate the scanner config (two levels up from this folder)
    base = os.path.dirname(__file__)
    scanner_cfg_path = os.path.normpath(os.path.join(base, '..', '..', 'regiokargotramtrain_qr_scanner_pi', 'config.json'))

    # default test messages if scanner config can't be read
    start_msgs = [
        {"TOPIC": "regiokargo/scanner/command", "PAYLOAD": '{"status":"start_scan"}'}
    ]
    result_sub_topics = ["regiokargo/scanner/result"]

    try:
        with open(scanner_cfg_path, 'r') as f:
            scfg = json.load(f)
        # prefer the user's naming
        start_msgs = scfg.get('scan_status_messages', scfg.get('start_scan_messages', start_msgs))
        # collect result topics to listen to
        res = scfg.get('scan_result_messages', [])
        if res:
            result_sub_topics = [e.get('TOPIC') for e in res if e.get('TOPIC')]
    except Exception:
        pass

    client = MQTTClient()
    connect_uri = 'mqtt://{user}:{pw}@127.0.0.1:1883/'.format(user=USER[0], pw=PASSWORDS[0])
    try:
        await client.connect(uri=connect_uri)
    except Exception as e:
        print(f"Test-client: cannot connect to broker: {e}")
        return

    # subscribe to result topics so we can display scanner replies
    for t in result_sub_topics:
        try:
            await client.subscribe([(t, 0)])
            print(f"Test-client subscribed to result topic: {t}")
        except Exception:
            pass

    # publish start messages (both user's PAYLOAD and a compatibility 'command' variant)
    for entry in start_msgs:
        topic = entry.get('TOPIC')
        payload_raw = entry.get('PAYLOAD')
        # try to parse PAYLOAD string as JSON, otherwise send as-is
        try:
            payload_obj = json.loads(payload_raw)
        except Exception:
            # PAYLOAD in some configs is missing braces; send as raw string
            payload_obj = None

        # publish original payload
        try:
            data = payload_raw if isinstance(payload_raw, str) else json.dumps(payload_raw)
            await client.publish(topic, data.encode('utf-8'))
            print(f"Test-client published to {topic}: {data}")
        except Exception as e:
            print(f"Publish failed: {e}")


    # simple loop to print messages arriving on subscribed topics for a short while
    try:
        for _ in range(60):
            try:
                message = await asyncio.wait_for(client.deliver_message(), timeout=1.0)
                packet = message.publish_packet
                topic = packet.variable_header.topic_name
                payload = packet.payload.data.decode('utf-8', errors='ignore')
                print(f"Test-client received on {topic}: {payload}")
            except asyncio.TimeoutError:
                # continue waiting
                pass
    except Exception:
        pass

    try:
        await client.disconnect()
    except Exception:
        pass


def main():

    # Override passwords file with settings defined in this script
    write_passwords()

    try:
        asyncio.run(run_server())
    except KeyboardInterrupt:
        print("Server exiting...")


if __name__ == "__main__":
    main()
