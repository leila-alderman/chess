# Chess

This project is a two-player game of chess played in the terminal. This game was written in Ruby following the principles of object-oriented design and thorough testing.

Features of this chess game include the following:
 - your current game can be saved, and you can load a previously saved game using JSON;
 - the game does not allow illegal moves, including those would leave or place the king in check; and
 - the board shown in the console rotates for each player.

[This project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project?ref=lnav) is part of the [The Odin Project](https://www.theodinproject.com) curriculum.

## To play this game

1. Fork this repository on GitHub.
2. Clone your forked reposity onto your local computer.
3. To play the game, `cd` into the project folder and type `ruby play.rb`.

## To test the code

1. Fork this repository on GitHub.
2. Clone your forked reposity onto your local computer.
3. To run the tests, you need to have `rspec` installed.
   - First, check to see if `rspec` is already installed by typing `rspec --version` into the command line.
   - If the response is similar to the following, then you already have `rspec` installed and can continue.
      ```bash
      RSpec 3.8
        - rspec-core 3.8.0
        - rspec-expectations 3.8.2
        - rspec-mocks 3.8.0
        - rspec-support 3.8.0
      ```
   - If you do not see output similar to the above, then you need to install `rspec` by typing `gem install rspec` into the command line.
   - Now, run `rspec --version` again to ensure that it installed correctly.
4. Use `cd` to move into the main directory and then enter `rspec` to run the tests.

## Development versions
 - Ruby 2.5.3
 - RSpec 3.8