#!/usr/bin/env python3
"""
Publish a `start_scan` command to the test broker for manual end-to-end testing.

Usage example:
  python tools/mqtt_pub_test.py --host 10.45.76.40 --port 1883 --user test_user --password test_password --compartment 5

This uses paho-mqtt. Install with `pip install paho-mqtt`.
"""
import argparse
import json

try:
    import paho.mqtt.publish as publish
except Exception:
    print("Missing dependency: please install with\n  pip install paho-mqtt")
    raise

parser = argparse.ArgumentParser()
parser.add_argument('--host', required=True)
parser.add_argument('--port', type=int, default=1883)
parser.add_argument('--user')
parser.add_argument('--password')
parser.add_argument('--topic', default='regiokargo/scanner/command')
parser.add_argument('--compartment', type=int, default=None)
args = parser.parse_args()

payload = {'command': 'start_scan'}
if args.compartment is not None:
    payload['expected_compartment'] = args.compartment

auth = None
if args.user and args.password:
    auth = {'username': args.user, 'password': args.password}

print(f"Publishing to {args.host}:{args.port} topic={args.topic} payload={payload}")
try:
    publish.single(args.topic, json.dumps(payload), hostname=args.host, port=args.port, auth=auth)
    print('Publish OK')
except Exception as e:
    print('Publish ERROR', e)
    raise
