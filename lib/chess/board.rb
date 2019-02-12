# The Board class creates an interconnected grid and then keeps track of the board state.

require "./lib/chess/square"
require "./lib/chess/king"
require "./lib/chess/rook"
require "./lib/chess/bishop"
require "./lib/chess/queen"
require "./lib/chess/knight"
require "./lib/chess/pawn"


class Board
  attr_accessor :grid
  attr_reader :rows, :columns

  def initialize 
    @rows = 8
    @columns = 8
    @grid = create_board
  end

  def self.new_full
    new_board = self.new
    new_board.setup_pieces
    return new_board
  end

  def setup_pieces
    setup_black_pieces
    setup_white_pieces   
  end

  def move_piece(color, start, stop)
    pos_i = grid.flatten.find { |square| square.name == start }
    piece = pos_i.piece
    # Reject move if no piece exists at the start position
    return "Invalid move: There is no piece at the start position." if piece.nil?
    # Reject move if the piece is a different color than the player
    return "Invalid move: You can only move pieces of your own color." if piece.color != color
    pos_f = grid.flatten.find { |square| square.name == stop }
    move_list = piece.list_moves(pos_i)
    # Reject move if the stop position is not in the move list
    return "Invalid move: That piece cannot move to that position." unless move_list.include?(pos_f)
    pos_f.piece = piece
    pos_i.piece = nil
  end

  private
  def create_board
    grid = []
    for i in 1..rows
      row = []
      for j in 1..columns
        row.push(create_square(i,j))
      end
      grid.push(row)
    end
    add_connections(grid)
    return grid
  end

  def create_square(i, j)
    rank = 9 - i
    file = (j + 96).chr
    Square.new({
      row: i,
      col: j,
      name: "#{file}#{rank}"
    })
  end

  def add_connections(grid)
    for i in 0..(rows-1)
      for j in 0..(columns-1)
        element = grid[i][j]
        (j-1).between?(0,columns-1) ? element.left =  grid[i][j-1] : element.left = nil
        (j+1).between?(0,columns-1) ? element.right = grid[i][j+1] : element.right = nil
        (i-1).between?(0,rows-1) ? element.up = grid[i-1][j] : element.up = nil
        (i+1).between?(0,rows-1) ? element.down = grid[i+1][j] : element.down = nil
        (i-1).between?(0,rows-1) && (j-1).between?(0,columns-1) ? element.up_left = grid[i-1][j-1] : element.up_left = nil
        (i+1).between?(0,rows-1) && (j-1).between?(0,columns-1) ? element.dwn_left = grid[i+1][j-1] : element.dwn_left = nil
        (i-1).between?(0,rows-1) && (j+1).between?(0,columns-1) ? element.up_right = grid[i-1][j+1] : element.up_right = nil
        (i+1).between?(0,rows-1) && (j+1).between?(0,columns-1) ? element.dwn_right = grid[i+1][j+1] : element.dwn_right = nil
      end
    end
  end

  def setup_black_pieces
    grid[0][0].piece = Rook.new("black")
    grid[0][1].piece = Knight.new("black")
    grid[0][2].piece = Bishop.new("black")
    grid[0][3].piece = Queen.new("black")
    grid[0][4].piece = King.new("black")
    grid[0][5].piece = Bishop.new("black")
    grid[0][6].piece = Knight.new("black")
    grid[0][7].piece = Rook.new("black")

    grid[1][0].piece = Pawn.new("black")
    grid[1][1].piece = Pawn.new("black")
    grid[1][2].piece = Pawn.new("black")
    grid[1][3].piece = Pawn.new("black")
    grid[1][4].piece = Pawn.new("black")
    grid[1][5].piece = Pawn.new("black")
    grid[1][6].piece = Pawn.new("black")
    grid[1][7].piece = Pawn.new("black")
  end

  def setup_white_pieces
    grid[7][0].piece = Rook.new("white")
    grid[7][1].piece = Knight.new("white")
    grid[7][2].piece = Bishop.new("white")
    grid[7][3].piece = Queen.new("white")
    grid[7][4].piece = King.new("white")
    grid[7][5].piece = Bishop.new("white")
    grid[7][6].piece = Knight.new("white")
    grid[7][7].piece = Rook.new("white")

    grid[6][0].piece = Pawn.new("white")
    grid[6][1].piece = Pawn.new("white")
    grid[6][2].piece = Pawn.new("white")
    grid[6][3].piece = Pawn.new("white")
    grid[6][4].piece = Pawn.new("white")
    grid[6][5].piece = Pawn.new("white")
    grid[6][6].piece = Pawn.new("white")
    grid[6][7].piece = Pawn.new("white")
  end

end
