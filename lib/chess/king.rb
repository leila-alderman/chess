# The King class creates a king piece that can generate a list of legal moves.

class King
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
    if @color == "white"
      @symbol = "\u2654"
    elsif @color == "black"
      @symbol = "\u265A"
    end
  end

  def list_moves(current_position)
    # A king can move one square in any direction.
    possible_moves = [
      current_position.left,
      current_position.right,
      current_position.up,
      current_position.down,
      current_position.up_left,
      current_position.dwn_left,
      current_position.up_right,
      current_position.dwn_right
    ]
    # No piece can move off of the board.
    move_list = possible_moves.select{ |square| !square.nil? }
    # A king cannot move to a square that is already occupied by a piece of the same color.
    move_list = move_list.select{ |square| square.piece.nil? || square.piece.color != color}
  end

end