# Packets | Protocol

## SNAPSHOT

Sending the complete world state 128\* times per second to all the clients

Binary packed data, represented here as JSON for convenience.

```JSON
{
  "timestamp": 12311,
  "snapshot_id": 56789,
  "delta_snapshot_id": 56780,
  "entry_count": 900,
  "entries": [
    {
      "id": 2323232323,
      "changed": false
    },
    {
      "id": 2323232323,
      "changed": true,
      "position": [128.58356, 531.97436],
      "velocity": [12.311231, 14.1221],
      "heading": 270.0
    }
  ]
}
```

* **timestamp**: uint32 - milliseconds since server started match
* **snapshot_id**: uint32 - used for delta encoding
* **delta_snapshot_id**: uint32 - id of snapshot to use for delta decoding
* **entry_count**: uint16 - number of entries in packet
* **entry**
  * **id**: uint32 - instance id of entity
  * **changed**: boolean - whether this entity has changed since last update
  * _--below bits only present if changed--_
  * **position**: vector - 2 floats representing entity's position in the world
  * **velocity**: vector - 2 floats entity's velocity
  * **heading**: float - entity's heading (facing) direction
