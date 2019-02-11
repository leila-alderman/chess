require "./lib/chess/knight"
require "./lib/chess/board"

RSpec.describe Knight do

  context "#initialize" do
    it "raises an error when initialized without a color" do
      expect{ Knight.new }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when initialized with a color" do
      expect { Knight.new("white")}.to_not raise_error
    end

  end

  before do
    @knight = Knight.new("black")
    @board = Board.new
    @initial_position = @board.grid[4][4]
    @corner_position = @board.grid[0][0]
  end

  context "#color" do
    it "can return the color" do
      expect(@knight.color).to eql "black"
    end

    it "cannot be changed" do
      expect{@knight.color = "white" }.to raise_error(NoMethodError)
    end
  end

  context "#list_moves" do
    it "raises an error when not given a current position" do
      expect{ @knight.list_moves }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when given a current position" do
      expect{ @knight.list_moves(@initial_position)}.to_not raise_error
    end

    it "includes valid moves in all directions" do
      expect(@knight.list_moves(@initial_position)).to eql [
        @board.grid[3][2], @board.grid[5][2], @board.grid[3][6], @board.grid[5][6], 
        @board.grid[2][3], @board.grid[2][5], @board.grid[6][3], @board.grid[6][5] 
      ]
    end

    it "doesn't include moves off the board" do
      expect(@knight.list_moves(@corner_position)).to eql [
        @board.grid[1][2], @board.grid[2][1]
      ]
    end

    it "doesn't allow the piece to move onto a square occupied by a piece of the same color" do
      @board.grid[5][6].piece = Knight.new("black")
      expect(@knight.list_moves(@initial_position)).to eql [
        @board.grid[3][2], @board.grid[5][2], @board.grid[3][6], 
        @board.grid[2][3], @board.grid[2][5], @board.grid[6][3], @board.grid[6][5]
      ]
    end

    it "allows the piece to move onto a square occupied by a piece of a different color" do
      @board.grid[5][6].piece = Knight.new("white")
      expect(@knight.list_moves(@initial_position)).to eql [
        @board.grid[3][2], @board.grid[5][2], @board.grid[3][6], @board.grid[5][6], 
        @board.grid[2][3], @board.grid[2][5], @board.grid[6][3], @board.grid[6][5]
      ]
    end
  end

end


