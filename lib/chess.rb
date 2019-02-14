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
    show_board_white
    show_board_black
    display_rules

  end

  private
  def show_board_white
    puts "\n\n"
    print "  "
    for i in 1..board.columns
      print " #{(i + 96).chr} "
    end
    print "\n"
    board.grid.each_with_index do |row, j|
      print "#{8-j} "
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
      print " #{8-j}"
      print "\n"
    end
    print "  "
    for i in 1..board.columns
      print " #{(i + 96).chr} "
    end
  end

  def show_board_black
    puts "\n\n"
    print "  "
    for i in 1..board.columns
      print " #{((9-i) + 96).chr} "
    end
    print "\n"
    reversed_board = board.grid.reverse
    reversed_board.each_with_index do |row, j|
      print "#{8-j} "
      reversed_row = row.reverse
      if j % 2 == 1
        reversed_row.each_with_index do |square, x|
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
        reversed_row.each_with_index do |square, x|
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
      print " #{8-j}"
      print "\n"
    end
    print "  "
    for i in 1..board.columns
      print " #{((9-i) + 96).chr} "
    end
  end

  def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
  end
  
  def gray(text)
    colorize(text, "\e[1;30;47m")
  end
  
  def white(text)
    colorize(text, "\e[1;30;107m")
  end

  def display_rules
  end

end