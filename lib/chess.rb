# The Chess class brings together the Board, Player, and GameLogic classes to create the game flow.

require "./lib/chess/player"
require "./lib/chess/board"
require "./lib/chess/game_logic"

class Chess
  attr_reader :board, :logic, :current_player, :other_player

  def initialize(name_1, name_2)
    @board = Board.new_full
    @logic = GameLogic.new(@board)
    @player_1 = Player.new(name_1, "white")
    @player_2 = Player.new(name_2, "black")
    @game_over = false
    @current_player, @other_player = @player_1, @player_2
  end

  def play
    system("clear")
    show_board_white
    display_rules
    while @game_over == false
      switch_players
      play_turn(current_player)
      check_draw
      check_win
    end
  end

  private
  def show_board_white
    print_white_header
    board.grid.each_with_index do |row, j|
      print_row(row, j)
    end
    print_white_footer
  end

  def show_board_black
    print_black_header
    reversed_board = board.grid.reverse
    reversed_board.each_with_index do |row, j|
      reversed_row = row.reverse
      print_row(reversed_row, j)
    end
    print_black_footer
  end

  def display_rules
    puts "\n \n \n"
    puts "Welcome #{player_1.name} and #{player_2.name}! \n"
    puts "The goal of chess is to checkmate your opponent by placing their king under immediate attack with no way out. 
Each turn, you can move one of your pieces by entering the piece's starting position and final position."
    puts "#{player_1.name}, you're playing white."
    puts "#{player_2.name}, you're playing black."
    puts "Let's play!\n \n"
  end

  def switch_players
    current_player, other_player = other_player, current_player
  end

  def play_turn(player)
    start, stop = get_input(player)
    player.move(board, start, stop)
  end

  def get_input(player)
    puts "It's #{player.name}'s turn."
    puts "Please enter the position of the piece you want to move (a1-h8). 
Alternatively, enter s to save the game or r to resign."
    start = gets.chomp
    if start == "r"
      puts "#{current_player.name} has resigned. #{other_player.name} wins!"
      puts "Thanks for playing!"
      @game_over = true
    elsif logic.valid_start?(player.color, start) == false
      get_input(player)
    end
    puts "Please enter the position of where you want to move your piece (a1-h8)."
    stop = gets.chomp
    unless logic.valid_move?(player.color, start, stop)
      get_input(player)
    end
    return start, stop
  end

  def print_black_header
    puts "\n\n"
    print "  "
    for i in 1..board.columns
      print " #{((9-i) + 96).chr} "
    end
    print "\n"
  end

  def print_black_footer
    print "  "
    for i in 1..board.columns
      print " #{((9-i) + 96).chr} "
    end
  end

  def print_white_header
    puts "\n\n"
    print "  "
    for i in 1..board.columns
      print " #{(i + 96).chr} "
    end
    print "\n"
  end

  def print_white_footer
    print "  "
    for i in 1..board.columns
      print " #{(i + 96).chr} "
    end
  end

  def print_white_square(square)
    if square.piece == nil
      print white("   ")
    else
      print white(" #{square.piece.symbol} ")
    end
  end

  def print_gray_square(square)
    if square.piece == nil
      print gray("   ")
    else
      print gray(" #{square.piece.symbol} ")
    end
  end

  def print_odd_row(row)
    row.each_with_index do |square, x|
      if x % 2 == 1
        print_white_square(square)
      else
        print_gray_square(square)
      end
    end
  end

  def print_even_row(row)
    row.each_with_index do |square, x|
      if x % 2 == 0
        print_white_square(square)
      else
        print_gray_square(square)
      end
    end
  end

  def print_row(row, j)
    print "#{8-j} "
    if j % 2 == 1
      print_odd_row(row)
    else
      print_even_row(row)
    end
    print " #{8-j}"
    print "\n"
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

end