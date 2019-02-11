# The Bishop class creates a rook piece that can generate a list of legal moves.

class Bishop
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def list_moves(current_position)
    # A bishop can move any number of squares along diagonals.
    move_list = list_up_left_moves(current_position)
    move_list += list_dwn_left_moves(current_position) 
    move_list += list_up_right_moves(current_position)
    move_list += list_dwn_right_moves(current_position)    
  end

  private
  def list_up_left_moves(current_position)
    possible_moves = []
    current = current_position
    up_left = current.up_left
    # Add moves going left until 
    #   1) the end of the board is reached; 
    #   2) the current square contains a piece of the opposite color; or
    #   3) the next square contains a piece of the same color.
    until up_left.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if up_left.piece != nil
        if up_left.piece.color == color
          break
        end
      end
      possible_moves.push(up_left)
      current = current.up_left
      up_left = current.up_left
    end
    return possible_moves
  end

  def list_dwn_left_moves(current_position)
    possible_moves = []
    current = current_position
    dwn_left = current.dwn_left
    # Add moves going left until 
    #   1) the end of the board is reached; 
    #   2) the current square contains a piece of the opposite color; or
    #   3) the next square contains a piece of the same color.
    until dwn_left.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if dwn_left.piece != nil
        if dwn_left.piece.color == color
          break
        end
      end
      possible_moves.push(dwn_left)
      current = current.dwn_left
      dwn_left = current.dwn_left
    end
    return possible_moves
  end

  def list_up_right_moves(current_position)
    possible_moves = []
    current = current_position
    up_right = current.up_right
    until up_right.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if up_right.piece != nil
        if up_right.piece.color == color
          break
        end
      end
      possible_moves.push(up_right)
      current = current.up_right
      up_right = current.up_right
    end
    return possible_moves
  end

  def list_dwn_right_moves(current_position)
    possible_moves = []
    current = current_position
    dwn_right = current.dwn_right
    until dwn_right.nil?
      if current.piece != nil
        if current.piece.color != color
          break
        end
      end
      if dwn_right.piece != nil
        if dwn_right.piece.color == color
          break
        end
      end
      possible_moves.push(dwn_right)
      current = current.dwn_right
      dwn_right = current.dwn_right
    end
    return possible_moves
  end

end