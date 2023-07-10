# I-MIC TDS
Making a top down shooter game in Ruby

## Design Philosophy
> * There is no single player: Game/Editor is always networked, even if there is only one player.
>
>   Ensures that any change is immediately usable over network.
>
>
> * Use ECS for game entities and game modes.
>
>   Ensures that code is decoupled, modular, reusable.
>
>
> * Use Behavior Trees for bot AI.
>
>   Enables emergent behavior from bots and enables them to have subtrees for playing the different game modes.
>
> * Use Mastermind AI Controller.
>
>   Gives bots goals and makes them behave like a cohesive group.
