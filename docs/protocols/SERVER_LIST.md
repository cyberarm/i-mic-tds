# Protocol
## SERVER LIST
How one fetches list of servers and submit 'em to the list.

## DATA
### Server list
```JSON
{
  "schema": 0,
  "servers":
  [
    {
      "uuid": "1213132-2313131-1231231-2313213231",
      "name": "Epic Server Name",
      "passworded": false,
      "game_mode": "CTF",
      "players": [ "frank", "jeff", "robert" ],
      "max_players": 16,
      "bots_fill_empty_slots": true,
      "coop": true,
      "bot_difficulty": 3,
      "spectators_allowed": true,
      "address": "uplink.link.example.com:56789",
      "map_uuid": "12312312-213131231-5413413-12313213",
      "map_name": "Grassland",
      "map_hash": "fa8a7f8afea87f89a8f7e8a98f7ea8f9a8e"
      "time_elapsed": 209.759,
      "time_left": 210.241,
      "match_start_time": "2026-01-01T02:17:41Z"
    }
  ]
}
```

## API
### Fetch list of servers
> GET `/api/v1/server_list`
```
application=i-mic-tds
version=0.1.0
magic=architect
```
Returns list of servers on success

### Submit server to list
> POST `/api/v1/server_list`
```
application=i-mic-tds
version=0.1.0
magic=architect
...misc. server_properties...
```
Returns success or failure

### Update server on list
Note: PUT request will be rejected unless ip address of server and requester are the same*
> PUT `/api/v1/server_list`
```
application=i-mic-tds
version=0.1.0
magic=architect
...misc. server_properties...
```
Returns success or failure

### Remove server from list
Note: DELETE request will be rejected unless ip address of server and requester are the same*
> DELETE `/api/v1/server_list`
```
application=i-mic-tds
version=0.1.0
magic=architect
server_uuid=313123-231231231-23121-232131232-2313123
```
Returns success or failure
