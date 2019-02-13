require "./lib/chess/king"
require "./lib/chess/board"

RSpec.describe King do

  context "#initialize" do
    it "raises an error when initialized without a color" do
      expect{ King.new }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when initialized with a color" do
      expect { King.new("white")}.to_not raise_error
    end

  end

  before do
    @king = King.new("black")
    @board = Board.new
    @initial_position = @board.grid[3][3]
    @corner_position = @board.grid[0][0]
  end

  context "#color" do
    it "can return the color" do
      expect(@king.color).to eql "black"
    end

    it "cannot be changed" do
      expect{@king.color = "white" }.to raise_error(NoMethodError)
    end
  end

  context "#symbol" do
    it "returns the white king symbol" do
      @white_king = King.new("white")
      expect(@white_king.symbol).to eql "♔"
    end
    
    it "returns the black king symbol" do
      @black_king = King.new("black")
      expect(@black_king.symbol).to eql "♚"
    end
  end

  context "#list_moves" do
    it "raises an error when not given a current position" do
      expect{ @king.list_moves }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when given a current position" do
      expect{ @king.list_moves(@initial_position)}.to_not raise_error
    end

    it "includes valid moves in all directions" do
      expect(@king.list_moves(@initial_position)).to eql [
        @board.grid[3][2], @board.grid[3][4], @board.grid[2][3], @board.grid[4][3], 
        @board.grid[2][2], @board.grid[4][2], @board.grid[2][4], @board.grid[4][4] 
      ]
    end

    it "doesn't include moves off the board" do
      expect(@king.list_moves(@corner_position)).to eql [
        @board.grid[0][1], @board.grid[1][0], @board.grid[1][1]
      ]
    end

    it "doesn't allow the piece to move onto a square occupied by a piece of the same color" do
      @board.grid[2][3].piece = King.new("black")
      expect(@king.list_moves(@initial_position)).to eql [
        @board.grid[3][2], @board.grid[3][4], @board.grid[4][3], 
        @board.grid[2][2], @board.grid[4][2], @board.grid[2][4], @board.grid[4][4] 
      ]
    end

    it "allows the piece to move onto a square occupied by a piece of a different color" do
      @board.grid[2][3].piece = King.new("white")
      expect(@king.list_moves(@initial_position)).to eql [
        @board.grid[3][2], @board.grid[3][4], @board.grid[2][3], @board.grid[4][3], 
        @board.grid[2][2], @board.grid[4][2], @board.grid[2][4], @board.grid[4][4] 
      ]
    end
  end

end


