#!/usr/bin/env python3
"""
MQTT subscribe test helper

Usage:
  python tools/mqtt_subscribe_test.py --host 10.45.76.40 --port 1883 --user test_user --password test_password

This script subscribes to `regiokargo/#` and prints incoming messages.
Requires: pip install paho-mqtt
"""
import argparse
import sys

try:
    import paho.mqtt.client as mqtt
except Exception:
    print("Missing dependency: please install with\n  pip install paho-mqtt")
    sys.exit(2)

parser = argparse.ArgumentParser()
parser.add_argument('--host', required=True)
parser.add_argument('--port', type=int, default=1883)
parser.add_argument('--user')
parser.add_argument('--password')
args = parser.parse_args()


def on_connect(client, userdata, flags, rc):
    print(f"SUB: connected rc= {rc}")
    client.subscribe("regiokargo/#")


def on_message(client, userdata, message):
    try:
        payload = message.payload.decode()
    except Exception:
        payload = message.payload
    print(f"RECEIVED: {message.topic} {payload}")


client = mqtt.Client()
if args.user and args.password:
    client.username_pw_set(args.user, args.password)
client.on_connect = on_connect
client.on_message = on_message

print(f"Connecting to {args.host}:{args.port} ...")
client.connect(args.host, args.port, 60)
print("Listening on regiokargo/# ... (CTRL+C to stop)")
try:
    client.loop_forever()
except KeyboardInterrupt:
    print('\nStopped')
    client.disconnect()
    sys.exit(0)
