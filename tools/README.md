Test-Tools for MQTT / WebSocket

Files:
- ws_handshake_test.py  - quick WebSocket handshake test (requires `websocket-client`)
- mqtt_pub_test.py      - publishes a `start_scan` command to the broker (requires `paho-mqtt`)

Install dependencies (on the machine you run tests from):

# Python 3 + pip
pip install websocket-client paho-mqtt

Examples:

# 1) Test WebSocket handshake to WS listener (use 9001 for the embedded test broker)
python tools/ws_handshake_test.py ws://10.45.76.40:9001

# 2) Publish a start_scan command that should trigger the Pi scanner
python tools/mqtt_pub_test.py --host 10.45.76.40 --port 1883 --user test_user --password test_password --compartment 5

What to look for:
- ws_handshake_test: prints `WS: connection opened` on success.
- mqtt_pub_test: prints `Publish OK` on success. If the Pi is subscribed and connected, it should log the received command.

If a test fails, gather the outputs (script stderr/stdout), broker logs and Pi console logs and paste them into the issue for fast debugging.
