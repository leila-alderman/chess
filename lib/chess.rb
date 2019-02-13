# The Chess class brings together the Board, Player, and GameLogic classes to create the game flow.

require "./lib/chess/player"
require "./lib/chess/board"
require "./lib/chess/game_logic"

class Chess
  attr_reader :board, :logic, :player_1, :player_2

  def initialize(name_1, name_2)
    @board = Board.new_full
    @logic = GameLogic.new(@board)
    @player_1 = Player.new(name_1, "white")
    @player_2 = Player.new(name_2, "black")
  end

  def play
    system("clear")
    show_board
    display_rules

  end

  private
  def show_board
    puts "\n\n"
    for i in 1..board.columns
      print "| #{i} " 
    end
    print "| \n"
    board.grid.each do |row|
      print row.map { |square| "| #{square.piece.marker} " }.join
      print "| \n"
    end
  end

end