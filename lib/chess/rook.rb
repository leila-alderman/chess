# The Rook class creates a rook piece that can generate a list of legal moves.

class Rook
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def list_moves(current_position)
    # A rook can move any number of squares along a rank or file.
    move_list = list_left_moves(current_position)
    move_list += list_right_moves(current_position)    
    
  end

  private
  def list_left_moves(current_position)
    possible_moves = []
    current = current_position
    left = current.left
    # Add moves going left until 
    #   1) the end of the board is reached; 
    #   2) the current square contains a piece of the opposite color; or
    #   3) the next square contains a piece of the same color.
    until left.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if left.piece != nil
        if left.piece.color == color
          break
        end
      end
      possible_moves.push(left)
      current = current.left
      left = current.left
    end
    return possible_moves
  end

  def list_right_moves(current_position)
    possible_moves = []
    current = current_position
    right = current.right
    # Add moves going right until 
    #   1) the end of the board is reached; 
    #   2) the current square contains a piece of the opposite color; or
    #   3) the next square contains a piece of the same color.
    until right.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if right.piece != nil
        if right.piece.color == color
          break
        end
      end
      possible_moves.push(right)
      current = current.right
      right = current.right
    end
    return possible_moves
  end

end