# File Format
## MAP
A JSON hash storing map metadata (name, author, grid size), shapes, map-specific prefabs, and entities.

## Data
Example:
```JSON
{
  "metadata": {
  },
  "shapes": [
    {}
  ],
  "prefabs": [
    {}
  ],
  "entities": [
    {}
  ]
}
```

### METADATA
```JSON
{
  "schema": 0,
  "name": "Christmas Cookie Rescue",
  "version": "0.1.0",
  "uuid": "019b74f1-683e-7c63-a542-38632c60244d",
  "authors": ["cyberarm"],
  "grid_size": 64,
  "created_at": "2025-12-31T14:33:43Z",
  "updated_at": "2025-12-31T14:43:52Z",
}
```

### SHAPES
```JSON
{
  "id": 10432,
  "name": "koth_a",
  "type": "overlay",
  "collidable": false,
  "polygon": [
    [128, 128],
    [64, 64],
    [192, 192]
  ],
  "color": 2284991026,
  "texture": "sand.png",
  "border": {
    "thickness": 2,
    "color": 2855416370
  }
}
```

### PREFABS
[See PREFABS.md](PREFABS.md)

### ENTITIES
```JSON
{
  "id": 1000037, // ID of prefab
  "components": [ // Overridden component(s) from prefab
    {
      "type": 0,
      "data": [
        {
          "name": "position",
          "type": "vector",
          "value": [
            0.0, 0.0, 0.0, 0.0
          ]
        }
      ]
    },
  ]
}
```
