require "./lib/chess/pawn"
require "./lib/chess/board"

RSpec.describe Pawn do

  context "#initialize" do
    it "raises an error when initialized without a color" do
      expect{ Pawn.new }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when initialized with a color" do
      expect { Pawn.new("white")}.to_not raise_error
    end
  end

  before do
    @white_pawn = Pawn.new("white")
    @black_pawn = Pawn.new("black")
    @board = Board.new
  end

  context "#color" do
    it "can return the color" do
      expect(@black_pawn.color).to eql "black"
    end

    it "cannot be changed" do
      expect{@black_pawn.color = "white" }.to raise_error(NoMethodError)
    end
  end

  context "#symbol" do
    it "returns the white pawn symbol" do
      expect(@white_pawn.symbol).to eql "♙"
    end
    
    it "returns the black pawn marker" do
      expect(@black_pawn.symbol).to eql "♟"
    end
  end

  context "#list_moves" do
    it "raises an error when not given a current position" do
      expect{ @black_pawn.list_moves }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when given a current position" do
      expect{ @black_pawn.list_moves(@board.grid[3][3])}.to_not raise_error
    end

    context "white pawn" do
      it "can move forward one space if not first move" do
        expect(@white_pawn.list_moves(@board.grid[3][3])).to eql [@board.grid[2][3]]
      end

      it "can move forward one or two spaces if first move" do
        expect(@white_pawn.list_moves(@board.grid[6][4])).to eql [@board.grid[5][4], @board.grid[4][4]]
      end

      it "can move up_left and up_right to capture" do
        @board.grid[2][2].piece = Pawn.new("black")
        @board.grid[2][4].piece = Pawn.new("black")
        expect(@white_pawn.list_moves(@board.grid[3][3])).to eql [
          @board.grid[2][3], @board.grid[2][2], @board.grid[2][4]
        ]
      end

      it "doesn't include moves off the board" do
        expect(@white_pawn.list_moves(@board.grid[0][2])).to eql []
      end

      it "can't move to a square occupied by a piece of the same color" do
        @board.grid[2][3].piece = Pawn.new("white") 
        @board.grid[2][2].piece = Pawn.new("black")
        expect(@white_pawn.list_moves(@board.grid[3][3])).to eql [@board.grid[2][2]]    
      end

      it "can't move forward to a square occupied by a piece of the opposite color" do
        @board.grid[2][3].piece = Pawn.new("black") 
        @board.grid[2][2].piece = Pawn.new("black")
        expect(@white_pawn.list_moves(@board.grid[3][3])).to eql [@board.grid[2][2]]    
      end
    end

    context "black pawn" do
      it "can move forward one space if not first move" do
        expect(@black_pawn.list_moves(@board.grid[3][3])).to eql [@board.grid[4][3]]
      end

      it "can move forward one or two spaces if first move" do
        expect(@black_pawn.list_moves(@board.grid[1][4])).to eql [@board.grid[2][4], @board.grid[3][4]]
      end

      it "can move up_left and up_right to capture" do
        @board.grid[4][2].piece = Pawn.new("white")
        @board.grid[4][4].piece = Pawn.new("white")
        expect(@black_pawn.list_moves(@board.grid[3][3])).to eql [
          @board.grid[4][3], @board.grid[4][2], @board.grid[4][4]
        ]
      end

      it "doesn't include moves off the board" do
        expect(@black_pawn.list_moves(@board.grid[7][2])).to eql []
      end

      it "can't move to a square occupied by a piece of the same color" do
        @board.grid[4][3].piece = Pawn.new("black") 
        @board.grid[4][4].piece = Pawn.new("white")
        expect(@black_pawn.list_moves(@board.grid[3][3])).to eql [@board.grid[4][4]]    
      end

      it "can't move forward to a square occupied by a piece of the opposite color" do
        @board.grid[4][3].piece = Pawn.new("white") 
        @board.grid[4][2].piece = Pawn.new("white")
        expect(@black_pawn.list_moves(@board.grid[3][3])).to eql [@board.grid[4][2]]    
      end
    end    
  end

end