# The Game class starts the game and can save the game.

require 'json'
require "./lib/chess.rb"

class Game

  def self.run
    system("clear")
    puts "Welcome!"
    puts "Let's play chess!"

    if File.exist?("save_file.json")
      game = load_game 
    else
      game = new_game
    end

    # If the play method returns true, save the game.
    if game.play
      save_state = game.to_json
      save_file = File.open("save_file.json", "w") { |f| f.puts save_state}
      puts "Your current game has been saved. See you again soon!"
    end
  end


  def self.load_game
    puts "Would you like to (1) load your saved game or (2) start a new game? \nPlease enter 1 or 2."
    answer = gets.chomp
    if answer == "1"
      save_file = File.read("save_file.json")
      save_state = JSON.parse(save_file)
      File.delete("save_file.json")
      game = Chess.load_game(save_state)
    else
      new_game
    end
  end

  def self.new_game
    puts "\n\nWhat is the first player's name?"
    name_1 = gets.chomp
    puts "\n\nWhat is the second player's name?"
    name_2 = gets.chomp
    random_names = [name_1, name_2].shuffle
    new_state = File.read("new_state.json")
    starting_board = JSON.parse(new_state)
    game = Chess.new_game(random_names[0], random_names[1], starting_board)
  end
end

Game.run