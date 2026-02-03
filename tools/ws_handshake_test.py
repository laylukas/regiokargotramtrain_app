#!/usr/bin/env python3
"""
Simple WebSocket handshake tester for MQTT broker websocket listener.

Usage:
  python tools/ws_handshake_test.py ws://10.45.76.40:9001

This script only tests whether a plain WebSocket handshake succeeds to the
specified URL. It does not attempt an MQTT CONNECT.
"""
import sys

try:
    import websocket
except Exception:
    print("Missing dependency: please install with\n  pip install websocket-client")
    sys.exit(2)

url = sys.argv[1] if len(sys.argv) > 1 else "ws://127.0.0.1:9001"
print(f"Testing WebSocket handshake to {url}")

# Many MQTT-over-WebSocket servers expect the Sec-WebSocket-Protocol to be
# set to the MQTT subprotocol (commonly 'mqtt' or 'mqttv3.1'). Try with a few
# common subprotocols to detect which one the broker accepts.
subprotocols_to_try = [['mqtt'], ['mqttv3.1', 'mqtt'], []]

for subprotos in subprotocols_to_try:
    try:
        if subprotos:
            print(f"Trying WS handshake with subprotocols={subprotos}")
            ws = websocket.create_connection(url, timeout=6, subprotocols=subprotos)
        else:
            print(f"Trying WS handshake without subprotocols")
            ws = websocket.create_connection(url, timeout=6)
        print("WS: connection opened (subprotocols=", subprotos, ")")
        print("WS: negotiated subprotocol:", ws.subprotocol)
        ws.close()
        print("WS: connection closed")
        sys.exit(0)
    except Exception as e:
        print("WS: ERROR with subprotocols=", subprotos, "->", e)

print("WS: all attempts failed")
sys.exit(1)
