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

  # The self.new class method creates a new Board instance
  # that is empty; it contains no pieces.
  def initialize 
    @rows = 8
    @columns = 8
    @grid = create_board
  end

  def move_piece(color, start, stop)
    pos_i = grid.flatten.find { |square| square.name == start }
    piece = pos_i.piece
    pos_f = grid.flatten.find { |square| square.name == stop }
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

end
