# Packets | Protocol

## INPUT

Send player inputs to the server 128\* times per second.

Binary packed data, represented here as JSON for convenience.

```JSON
{
  "timestamp": 12311,
  "input_id": 21411,
  "changed": true,
  "inputs":
  {
    "forward": true,
    "backward": false,
    "left": false,
    "right": true,
    "sprint": false,
    "crouch": false,
    "interact": true,
    "special_action": false
    "primary_fire": true,
    "secondary_fire": false,
    "melee": false
  },
  "aim": {
    "heading": 271.1231
  }
}
```

* **timestamp**: uint32 - milliseconds since client joined match
* **input_id**: uint32 - client unique id of input snapshot
* **changed**: boolean - whether anything has changed since last input snapshot
* **inputs**: uint32 - bit packed array of booleans for all inputs
* **heading**: float - angle of where player is aiming/facing
