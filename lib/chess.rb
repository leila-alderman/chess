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
      print " #{(i + 96).chr} "
    end
    print "\n"
    board.grid.each_with_index do |row, j|
      print 9-j
      if j % 2 == 1
        row.each_with_index do |square, x|
          if x % 2 == 1
            if square.piece == nil
              print white("   ")
            else
              print white(" #{square.piece.symbol} ")
            end
          else
            if square.piece == nil
              print gray("   ")
            else
              print gray(" #{square.piece.symbol} ")
            end
          end
        end
      else
        row.each_with_index do |square, x|
          if x % 2 == 0
            if square.piece == nil
              print white("   ")
            else
              print white(" #{square.piece.symbol} ")
            end
          else
            if square.piece == nil
              print gray("   ")
            else
              print gray(" #{square.piece.symbol} ")
            end
          end
        end
      end
      print 9-j
      print "\n"
    end
    for i in 1..board.columns
      print " #{(i + 96).chr} "
    end
  end

  def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
  end
  
  def gray(text); colorize(text, "\e[1;30;47m"); end
  def white(text); colorize(text, "\e[1;30;107m"); end

  def display_rules
  end

end