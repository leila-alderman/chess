# The Pawn class creates a pawn piece that can generate a list of legal moves.

class Pawn
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def list_moves(current_position)
    # A pawn can move:
    #   1) one square forward;
    #   2) two squares forward on its first move;
    #   3) up_left or up_right to capture.
    if color == "white"
      possible_moves = list_white_moves(current_position)
    elsif color == "black"
      possible_moves = list_black_moves(current_position)
    end
    
    # No piece can move off of the board.
    move_list = possible_moves.select{ |square| !square.nil? }
    # A pawn cannot move to a square that is already occupied by a piece of the same color.
    move_list = move_list.select{ |square| square.piece.nil? || square.piece.color != color}
  end

  private
  def list_white_moves(current)
    move_list = []
    unless current.up.nil?
      if current.up.piece.nil?
        move_list.push(current.up)
      end
    end
    if current.row == 7
      move_list.push(current.up.up)
    end
    unless current.up_left.nil?
      unless current.up_left.piece.nil?
        if current.up_left.piece.color != color
          move_list.push(current.up_left)
        end
      end
    end
    unless current.up_right.nil?
      unless current.up_right.piece.nil?
        if current.up_right.piece.color != color
          move_list.push(current.up_right)
        end
      end
    end
    return move_list
  end

  def list_black_moves(current)
    move_list = []
    unless current.down.nil?
      if current.down.piece.nil?
        move_list.push(current.down)
      end
    end
    if current.row == 2
      move_list.push(current.down.down)
    end
    unless current.dwn_left.nil?
      unless current.dwn_left.piece.nil?
        if current.dwn_left.piece.color != color
          move_list.push(current.dwn_left)
        end
      end
    end
    unless current.dwn_right.nil?
      unless current.dwn_right.piece.nil?
        if current.dwn_right.piece.color != color
          move_list.push(current.dwn_right)
        end
      end
    end
    return move_list
  end

end