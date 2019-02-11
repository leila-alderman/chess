require "./lib/chess/rook"
require "./lib/chess/board"

RSpec.describe Rook do

  context "#initialize" do
    it "raises an error when initialized without a color" do
      expect{ Rook.new }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when initialized with a color" do
      expect { Rook.new("white")}.to_not raise_error
    end

  end

  before do
    @rook = Rook.new("black")
    @board = Board.new
    @initial_position = @board.grid[3][4]
  end

  context "#color" do
    it "can return the color" do
      expect(@rook.color).to eql "black"
    end

    it "cannot be changed" do
      expect{@rook.color = "white" }.to raise_error(NoMethodError)
    end
  end

  context "#list_moves" do
    it "raises an error when not given a current position" do
      expect{ @rook.list_moves }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when given a current position" do
      expect{ @rook.list_moves(@initial_position)}.to_not raise_error
    end

    it "includes valid moves in all directions" do
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops before squares occupied by a piece of the same color: left" do
      @board.grid[3][1].piece = Rook.new("black")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2],                                         # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops in squares occupied by a piece of a different color: left" do
      @board.grid[3][1].piece = Rook.new("white")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1],                      # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops before squares occupied by a piece of the same color: right" do
      @board.grid[3][6].piece = Rook.new("black")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5],                                                            # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops in squares occupied by a piece of a different color: right" do
      @board.grid[3][6].piece = Rook.new("white")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6],                                         # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops before squares occupied by a piece of the same color: up" do
      @board.grid[1][4].piece = Rook.new("black")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4],                                                            # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops in squares occupied by a piece of a different color: up" do
      @board.grid[1][4].piece = Rook.new("white")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4],                                         # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4]    # down
      ]
    end

    it "stops before squares occupied by a piece of the same color: down" do
      @board.grid[6][4].piece = Rook.new("black")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4]                                          # down
      ]
    end

    it "stops in squares occupied by a piece of a different color: down" do
      @board.grid[6][4].piece = Rook.new("white")
      expect(@rook.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4]                       # down
      ]
    end
  end

end


