# The Player class creates a player with a color who can make moves.

class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def move(board, start, stop)
    board.move_piece(color, start, stop)
  end

end