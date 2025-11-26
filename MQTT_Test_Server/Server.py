import asyncio
from asyncio import CancelledError
import logging
import yaml
from amqtt.broker import Broker
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
        while True:
            await asyncio.sleep(1)
    except CancelledError:
        await broker.shutdown()


def main():

    # Override passwords file with settings defined in this script
    write_passwords()

    try:
        asyncio.run(run_server())
    except KeyboardInterrupt:
        print("Server exiting...")


if __name__ == "__main__":
    main()
