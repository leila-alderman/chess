# The Chess class brings together the Board, Player, and GameLogic classes to create the game flow.

require "./lib/chess/player"
require "./lib/chess/board"
require "./lib/chess/game_logic"

class Chess
  attr_reader :board, :logic

  def initialize(name_1, name_2)
    @board = Board.new_full
    @logic = GameLogic.new(@board)
    @player_1 = Player.new(name_1, "white")
    @player_2 = Player.new(name_2, "black")
    @game_over = false
    @save = false
    @current_player, @other_player = @player_1, @player_2
  end

  def play
    system("clear")
    display_rules
    show_board_white
    while @game_over == false
      setup_turn
      check_for_check
      play_turn
      check_for_checkmate
      check_for_stalemate
      switch_players
    end
    return @save
  end

  private
  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def setup_turn
    system("clear")
    show_board_white if @current_player.color == "white"
    show_board_black if @current_player.color == "black"
  end
  
  def play_turn
    puts "It's #{@current_player.name}'s turn."
    start, stop = get_input
    return if @game_over == true
    @current_player.move(board, start, stop)
  end

  def check_for_check
    if logic.check?(@current_player.color)
      puts "#{@current_player.name} is now in check!\n"
    end
  end
  
  def check_for_checkmate
    if logic.checkmate?(@other_player.color)
      puts "Checkmate!"
      puts "Congratulations, #{@current_player.name}! You won!"
      @game_over = true
    end
  end

  def check_for_stalemate
    if logic.stalemate?(@other_player.color)
      puts "It's a stalemate!"
      puts "Game over. It's a tie."
      @game_over = true
    end
  end

  def display_rules
    puts "Welcome #{@current_player.name} and #{@other_player.name}! \n"
    puts "\nThe goal of chess is to checkmate your opponent by placing their king under immediate attack with no way out. 
Each turn, you can move one of your pieces by entering the piece's starting position and final position."
    puts "\n\n#{@current_player.name}, you're playing white, and this is your king: " + white(" \u2654 ")
    puts "#{@other_player.name}, you're playing black, and this is your king: " + white(" \u265A ")
    puts "\nLet's play!"
    puts "\n\nPress enter when you're ready to start."
    ready = false
    while ready == false
      entry = gets
      ready = true if entry = "\n"
    end
    system("clear")
  end

  def get_input
    valid = false
    valid_start = false
    until valid
      until valid_start
        puts "\nPlease enter the position of the piece you want to move (a1-h8). 
Alternatively, enter s to save the game or r to resign.\n"
        start = gets.chomp
        if start == "r"
          puts "#{@current_player.name} has resigned. #{@other_player.name} wins!"
          puts "Thanks for playing!"
          @game_over = true
          return
        end
        valid_start = true if logic.valid_start?(@current_player.color, start)
      end
      puts "\nPlease enter the position of where you want to move your piece (a1-h8).\n"
      stop = gets.chomp
      logic.valid_move?(@current_player.color, start, stop) ? valid = true : valid_start = false
    end
    return start, stop
  end

  def show_board_white
    print_white_header
    board.grid.each_with_index do |row, j|
      print "#{8-j} "
      print_rows(row, j)
      print " #{8-j}\n"
    end
    print_white_footer
  end

  def show_board_black
    print_black_header
    reversed_board = board.grid.reverse
    reversed_board.each_with_index do |row, j|
      reversed_row = row.reverse
      print "#{j+1} "
      print_rows(reversed_row, j)
      print " #{j+1}\n"
    end
    print_black_footer
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
    puts "\n\n"
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
    puts "\n\n"
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

  def print_rows(row, j)
    if j % 2 == 1
      print_odd_row(row)
    else
      print_even_row(row)
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