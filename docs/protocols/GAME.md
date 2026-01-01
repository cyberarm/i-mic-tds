# Protocol
## GAME

* Client requests to connect
* Server accepts client
  * Server sends client game configuration data (map, game mode, misc. options)
  * Client loads or downloads map from server
  * Client notifies server when ready
  * Server creates entity for player to control
  * Client spawns and plays for match
  * Server finishes match
    * Server notifies clients with match result
    * Client stops playing match and is show match results
    * Server starts next match after 15-30 seconds
      * Client resets and soft-reconnects to server
* Server rejects client
  * Client is rejected, connection is closed after telling them off.
