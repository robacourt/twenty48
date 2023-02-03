# Twenty48

An implementation of the game 2048 by Rob A'Court as part of a tech assessment by V7

## To run

  * Ensure you have Elixir installed (version 1.12 or above)
  * In your console run `./start`
  * Visit [`http://localhost:4000`](http://localhost:4000) from your browser

## Documentation

The game logic is in 3 modules:
  * Game - which consists of a board and a status (playing, won or lost)
  * Board - a list of rows, with functions to add pieces and to slide the tiles in any direction
  * Row - with logic on how to slide and merge number tiles

To tests for each of these modules document the functionality of them

For the purposes of this assessment, in the code the tiles are represented by:
  * `:_` - for spaces
  * `:x` - for obstacles
  * integers - for number tiles

For a real game you would probably want to represent tile transitions in the UI.
To do this the tiles could be represented by maps or structs with an ID for each piece
(e.g. `%{type: :number, value: 4, id: 7}`) so that where a piece has been moved to
can be easily worked out

![Game example](https://github.com/robacourt/twenty48/blob/main/example-game.png?raw=true)
