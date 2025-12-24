# I-MIC TDS
Making a top down shooter game in Ruby

## Install
:wave:

## Development
:wave:

## Design Philosophy
### THERE IS (logically) NO SINGLE PLAYER
Game and Editor are always networked, even if there is only one player.

Ensures that any change is immediately usable over network, even if it may be laggy.

### Be playable with upto 250ms ping and 10% packet loss
The internet is a wild place and packets get waylaid.

### Use ECS for game entities and game modes
Ensures that code is decoupled, modular, reusable.

### Use Utility for bot AI
Enables emergent behavior from bots.

### Use Mastermind AI Controller
Manages squads of bots and gives squads goals to play the game mode effectively.

### Use Squads of Agents
Make groups of agents (bots) work "together" to achieve the goal given by the Mastermind.

## Resources
* Timestep / Physics: https://gafferongames.com/post/fix_your_timestep/
* Netcode: https://www.gabrielgambetta.com/client-server-game-architecture.html
* Netcode: https://gafferongames.com/post/snapshot_interpolation/
