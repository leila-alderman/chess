# The Square class creates nodes that have a position name, can hold a piece, and can connect to other nodes in 8 directions.

class Square
  attr_reader :row, :col, :name
  attr_accessor :piece, :left, :right, :up, :down
  attr_accessor :up_left, :dwn_left, :up_right, :dwn_right

  def initialize(input)
    args = defaults.merge(input)
    @row = args[:row]
    @col = args[:col]
    @name = args[:name]
    @piece = args[:piece]
    @left = args[:left]
    @right = args[:right]
    @up = args[:up]
    @down = args[:down]
    @up_left = args[:up_left]
    @dwn_left = args[:dwn_left]
    @up_right = args[:up_right]
    @dwn_right = args[:dwn_right]
  end

  # Replace the #inspect method so that it doesn't kill RSpec
  def inspect
    "I'm located at row #{row} and col #{col}"
  end

  # Replace the #to_s method so that it doesn't kill RSpec
  def to_s
    "I'm located at row #{row} and col #{col}"
  end

  private
  def defaults
    {
    piece: nil,
    left: nil,
    right: nil,
    up: nil,
    down: nil,
    up_left: nil,
    dwn_left: nil,
    up_right: nil,
    dwn_right: nil
    }
  end

end