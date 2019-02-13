# The Knight class creates a knight piece that can generate a list of legal moves.

class Knight
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
    if @color == "white"
      @symbol = "\u2658"
    elsif @color == "black"
      @symbol = "\u265E"
    end
  end

  def list_moves(current_position)
    # A knight can move two squares up and one square across in any direction.
    move_list = list_left_moves(current_position)
    move_list += list_right_moves(current_position) 
    move_list += list_up_moves(current_position)
    move_list += list_down_moves(current_position) 

    # A knight cannot move to a square that is already occupied by a piece of the same color.
    move_list = move_list.select{ |square| square.piece.nil? || square.piece.color != color}
  end

  private
  def list_left_moves(current_position)
    possible_moves = []
    current = current_position
    unless current.left.nil?
      unless current.left.left.nil?
        unless current.left.left.up.nil?
          possible_moves.push(current.left.left.up)
        end
        unless current.left.left.down.nil?
          possible_moves.push(current.left.left.down)
        end
      end
    end
    return possible_moves
  end

  def list_right_moves(current_position)
    possible_moves = []
    current = current_position
    unless current.right.nil?
      unless current.right.right.nil?
        unless current.right.right.up.nil?
          possible_moves.push(current.right.right.up)
        end
        unless current.right.right.down.nil?
          possible_moves.push(current.right.right.down)
        end
      end
    end
    return possible_moves
  end

  def list_up_moves(current_position)
    possible_moves = []
    current = current_position
    unless current.up.nil?
      unless current.up.up.nil?
        unless current.up.up.left.nil?
          possible_moves.push(current.up.up.left)
        end
        unless current.up.up.right.nil?
          possible_moves.push(current.up.up.right)
        end
      end
    end
    return possible_moves
  end

  def list_down_moves(current_position)
    possible_moves = []
    current = current_position
    unless current.down.nil?
      unless current.down.down.nil?
        unless current.down.down.left.nil?
          possible_moves.push(current.down.down.left)
        end
        unless current.down.down.right.nil?
          possible_moves.push(current.down.down.right)
        end
      end
    end
    return possible_moves
  end


end