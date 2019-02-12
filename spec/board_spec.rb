require "./lib/chess/board.rb"

RSpec.describe Board do
  before do 
    @board = Board.new 
  end

  context "#initialize" do
    it "has a default piece of nil" do
      expect(@board.grid[0][0].piece).to be_nil
    end

    it "creates a grid with 8 rows" do
      expect(@board.grid.length).to eql 8
    end

    it "creates a grid with 8 columns" do
      @board.grid.each do |row|
        expect(row.length).to eql 8
      end
    end
  end

  context "#grid" do
    it "can access an empty cell" do
      expect(@board.grid[5][2].piece).to be_nil
    end

    it "can change the grid" do
      @board.grid[4][3].piece = "X"
      expect(@board.grid[4][3].piece).to eql "X"
    end
  end

  context "#create_board" do
    context "Square#left" do
      it "can access squares to the left" do
        expect(@board.grid[4][3].left).to equal @board.grid[4][2]
      end

      it "can access squares farther to the left" do
        expect(@board.grid[2][5].left.left).to equal @board.grid[2][3]
      end

      it "returns nil outside of the board" do
        expect(@board.grid[3][0].left).to eql nil
      end
    end

    context "Square#right" do
      it "can access squares to the right" do
        expect(@board.grid[4][4].right).to equal @board.grid[4][5]
      end

      it "can access squares farther to the right" do
        expect(@board.grid[3][2].right.right).to equal @board.grid[3][4]
      end

      it "returns nil outside of the board" do
        expect(@board.grid[1][7].right).to be_nil
      end
    end

    context "Square#up" do
      it "can access squares up" do
        expect(@board.grid[3][3].up).to equal @board.grid[2][3]
      end

      it "can access squares farther up" do
        expect(@board.grid[2][0].up.up).to equal @board.grid[0][0]
      end

      it "returns nil outside of the board" do
        expect(@board.grid[0][4].up).to be_nil
      end
    end

    context "Square#down" do
      it "can access squares down" do
        expect(@board.grid[4][3].left).to equal @board.grid[4][2]
      end

      it "can access squares farther down" do
        expect(@board.grid[2][5].left.left).to equal @board.grid[2][3]
      end

      it "returns nil outside of the board" do
        expect(@board.grid[7][3].down).to be_nil
      end
    end

    context "Square#up_left" do
      it "can access squares to the upper left" do
        expect(@board.grid[3][3].up_left).to equal @board.grid[2][2]
      end

      it "can access squares farther to the upper left" do
        expect(@board.grid[2][2].up_left.up_left).to equal @board.grid[0][0]
      end
    end

    context "Square#dwn_left" do
      it "can access squares to the lower left" do
        expect(@board.grid[3][3].dwn_left).to equal @board.grid[4][2]
      end

      it "can access squares farther to the lower left" do
        expect(@board.grid[2][5].dwn_left.dwn_left).to equal @board.grid[4][3]
      end
    end

    context "Square#up_right" do
      it "can access squares to the upper right" do
        expect(@board.grid[4][0].up_right).to equal @board.grid[3][1]
      end

      it "can access squares farther to the upper right" do
        expect(@board.grid[5][2].up_right.up_right).to equal @board.grid[3][4]
      end
    end

    context "Square#dwn_right" do
      it "can access squares to the lower right" do
        expect(@board.grid[3][3].dwn_right).to equal @board.grid[4][4]
      end

      it "can access squares farther to the lower right" do
        expect(@board.grid[2][0].dwn_right.dwn_right).to equal @board.grid[4][2]
      end
    end

    context "Square#name" do
      it "gives correct name for a8" do
        expect(@board.grid[0][0].name).to eql "a8"
      end

      it "gives correct name for a1" do
        expect(@board.grid[7][0].name).to eql "a1"
      end

      it "gives correct name for h1" do
        expect(@board.grid[7][7].name).to eql "h1"
      end
      
      it "gives correct name for e5" do
        expect(@board.grid[3][4].name).to eql "e5"
      end

      it "gives correct name for h5" do
        expect(@board.grid[3][7].name).to eql "h5"
      end
    end
  end

  before do
    @full_board = Board.new_full
  end

  context "#setup_pieces" do
    it "places the black king" do
      expect(@full_board.grid[0][4].piece.is_a? King).to eql true
    end

    it "places the white king" do
      expect(@full_board.grid[7][4].piece.is_a? King).to eql true
    end

    it "place a black pawn" do
      expect(@full_board.grid[1][6].piece.is_a? Pawn).to eql true
    end

    it "place a white pawn" do
      expect(@full_board.grid[1][6].piece.is_a? Pawn).to eql true
    end
  end

  context "#move_piece" do
    it "raises an error if not given any input" do
      expect{ @full_board.move_piece }.to raise_error(ArgumentError)
    end

    it "raises an error if given too few arguments" do
      expect{ @full_board.move_piece("white", "a3")}.to raise_error(ArgumentError)
    end

    it "doesn't raise an error if given three arguments" do
      expect{ @full_board.move_piece("white", "a3", "c4")}.to_not raise_error
    end

    it "rejects move if no piece at start position" do
      expect(@full_board.move_piece("white", "c5", "c4")).to eql "Invalid move: There is no piece at the start position."
    end

    it "rejects move if piece is different color than player" do
      expect(@full_board.move_piece("black", "c2", "c4")).to eql "Invalid move: You can only move pieces of your own color."
    end

    it "rejects move if stop position is not in move list" do
      expect(@full_board.move_piece("white", "c2", "b3")).to eql "Invalid move: That piece cannot move to that position."
    end

    it "can move a pawn" do
      @full_board.move_piece("white", "c2", "c4")
      expect(@full_board.grid[4][2].piece.class).to eql Pawn
    end

    it "can move a queen" do
      @full_board.move_piece("white", "e2", "e4")
      @full_board.move_piece("white", "d1", "h5")
      expect(@full_board.grid[3][7].piece.class).to eql Queen
    end

    it "can capture a different color piece" do
      @full_board.move_piece("white", "e2", "e4")
      @full_board.move_piece("black", "h7", "h5")
      @full_board.move_piece("white", "d1", "h5")
      expect(@full_board.grid[3][7].piece.class).to eql Queen
    end

  end

end