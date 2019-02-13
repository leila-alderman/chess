# The Rook class creates a rook piece that can generate a list of legal moves.

class Rook
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
    if @color == "white"
      @symbol = "\u2656"
    elsif @color == "black"
      @symbol = "\u265C"
    end
  end

  def list_moves(current_position)
    # A rook can move any number of squares along a rank or file.
    move_list = list_left_moves(current_position)
    move_list += list_right_moves(current_position) 
    move_list += list_up_moves(current_position)
    move_list += list_down_moves(current_position)    
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

  def list_up_moves(current_position)
    possible_moves = []
    current = current_position
    up = current.up
    until up.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if up.piece != nil
        if up.piece.color == color
          break
        end
      end
      possible_moves.push(up)
      current = current.up
      up = current.up
    end
    return possible_moves
  end

  def list_down_moves(current_position)
    possible_moves = []
    current = current_position
    down = current.down
    until down.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if down.piece != nil
        if down.piece.color == color
          break
        end
      end
      possible_moves.push(down)
      current = current.down
      down = current.down
    end
    return possible_moves
  end


end