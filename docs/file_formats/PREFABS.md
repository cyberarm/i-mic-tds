# File Format

## PREFABS

A JSON array storing the list of global, or map local, entity prefabs.

Global prefab IDs start at 1 million while map local prefab IDs start at 1 billion to avoid collions for the rest of time, probably.

Global prefab IDs can only increase and can NEVER be reused.

Map local prefab IDs can only increase and can NEVER be reused, but always start at 1 billion when creating a map.

Map local prefabs CAN override global prefabs.

## DATA

Example:

```JSON
{
  "schema": 0,
  "global": true,
  "prefab_sequence_id": 1000005639, // ID that the last created prefab used, increment by one for each new prefab.
  "prefabs":
  [
    {
      "id": 1312312,
      "name": "Human friendly name, IS unique",
      "overriding_id": -1, // allow a map specific prefab to override a global prefab
      "components": [
        {
          "type": 0, // unique component ID
          "data": [ // array of hashes
            {
              "name": "position", // name is always a lowercase string
              "type": "vector" // type is always a lowercase string or maybe an enum integer...?
              "value": [ // value is always an array of numeric or string values
                0.0, 0.0, 0.0, 0.0
              ]
            }
          ]
        },
        // ...misc. examples
        {
          "type": 128,
          "data": [
            {
              "name": "team_id",
              "type": "integer"
              "value": [
                -1
              ]
            }
          ],
        },
        {
          "type": 64,
          "data": [
            {
              "name": "self_image",
              "type": "string"
              "value": [
                "friend.png"
              ]
            },
            {
              "name": "friend_image",
              "type": "string"
              "value": [
                "friend.png"
              ]
            },
            {
              "name": "enemy_image",
              "type": "string"
              "value": [
                "enemy.png"
              ]
            },
            {
              "name": "origin_offset",
              "type": "vector"
              "value": [
                0.0, 0.0, 0.0, 0.0
              ]
            }
          ]
        }
      ]
    }
  ]
}
```
