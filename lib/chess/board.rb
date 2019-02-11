# The Board class creates an interconnected grid and then keeps track of the board state.

require "./lib/chess/square.rb"

class Board
  attr_accessor :grid
  attr_reader :rows, :columns

  def initialize 
    @rows = 8
    @columns = 8
    @grid = create_board
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
    rank = 8 - i
    file = (j + 97).chr
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
        if j-1 >= 0 && j-1 <= columns-1
          element.left =  grid[i][j-1]
        else
          element.left = nil
        end
        if j+1 >= 0 && j+1 <= columns-1
          element.right = grid[i][j+1]
        else
          element.right = nil
        end
        if i-1 >= 0 && i-1 <= rows-1
          element.up = grid[i-1][j]
        else
          element.up = nil
        end
        if i+1 >= 0 && i+1 <= rows-1
          element.down = grid[i+1][j]
        else
          element.down = nil
        end
        if (i-1 >= 0 && i-1 <= rows-1) && (j-1 >= 0 && j-1 <= columns-1)
          element.up_left = grid[i-1][j-1]
        else
          element.up_left = nil
        end
        if (i+1 >= 0 && i+1 <= rows-1) && (j-1 >= 0 && j-1 <= columns-1)
          element.dwn_left = grid[i+1][j-1]
        else
          element.dwn_left = nil
        end
        if (i-1 >= 0 && i-1 <= rows-1) && (j+1 >= 0 && j+1 <= columns-1)
          element.up_right = grid[i-1][j+1]
        else
          element.up_right = nil
        end
        if (i+1 >= 0 && i+1 <= rows-1) && (j+1 >= 0 && j+1 <= columns-1)
          element.dwn_right = grid[i+1][j+1]
        else
          element.dwn_right = nil
        end
      end
    end
  end

end
