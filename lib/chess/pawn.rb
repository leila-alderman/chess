# The Pawn class creates a pawn piece that can generate a list of legal moves.

class Pawn
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
    if @color == "white"
      @symbol = "\u2659"
    elsif @color == "black"
      @symbol = "\u265F"
    end
  end

  def list_moves(current_position)
    # A pawn can move:
    #   1) one square forward;
    #   2) two squares forward on its first move;
    #   3) up_left or up_right to capture.
    if color == "white"
      return list_white_moves(current_position)
    elsif color == "black"
      return list_black_moves(current_position)
    end
  end

  private
  def list_white_moves(current)
    move_list = []
    move_list.push(move_up_one(current)) unless move_up_one(current).nil?
    move_list.push(move_up_two(current)) unless move_up_two(current).nil?
    move_list.push(capture_up_left(current)) unless capture_up_left(current).nil?
    move_list.push(capture_up_right(current)) unless capture_up_right(current).nil? 
    return move_list
  end

  def move_up_one(current)
    unless current.up.nil?
      if current.up.piece.nil?
        return current.up
      end
    end
  end

  def move_up_two(current)
    if current.row == 7 && current.up.up.piece.nil?
      return current.up.up
    end
  end

  def capture_up_left(current)
    unless current.up_left.nil?
      unless current.up_left.piece.nil?
        if current.up_left.piece.color != color
          return current.up_left
        end
      end
    end
  end

  def capture_up_right(current)
    unless current.up_right.nil?
      unless current.up_right.piece.nil?
        if current.up_right.piece.color != color
          return current.up_right
        end
      end
    end
  end

  def list_black_moves(current)
    move_list = []
    move_list.push(move_down_one(current)) unless move_down_one(current).nil?
    move_list.push(move_down_two(current)) unless move_down_two(current).nil?
    move_list.push(capture_dwn_left(current)) unless capture_dwn_left(current).nil?
    move_list.push(capture_dwn_right(current)) unless capture_dwn_right(current).nil?
    return move_list
  end

  def move_down_one(current)
    unless current.down.nil?
      if current.down.piece.nil?
        return current.down
      end
    end
  end

  def move_down_two(current)
    if current.row == 2 && current.down.down.piece.nil?
      return current.down.down
    end
  end

  def capture_dwn_left(current)
    unless current.dwn_left.nil?
      unless current.dwn_left.piece.nil?
        if current.dwn_left.piece.color != color
          return current.dwn_left
        end
      end
    end
  end

  def capture_dwn_right(current)
    unless current.dwn_right.nil?
      unless current.dwn_right.piece.nil?
        if current.dwn_right.piece.color != color
          return current.dwn_right
        end
      end
    end
  end

end