require "./lib/chess/queen"
require "./lib/chess/board"

RSpec.describe Queen do

  context "#initialize" do
    it "raises an error when initialized without a color" do
      expect{ Queen.new }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when initialized with a color" do
      expect { Queen.new("white")}.to_not raise_error
    end

  end

  before do
    @queen = Queen.new("black")
    @board = Board.new
    @initial_position = @board.grid[3][4]
  end

  context "#color" do
    it "can return the color" do
      expect(@queen.color).to eql "black"
    end

    it "cannot be changed" do
      expect{@queen.color = "white" }.to raise_error(NoMethodError)
    end
  end

  context "#symbol" do
    it "returns the white queen symbol" do
      @white_queen = Queen.new("white")
      expect(@white_queen.symbol).to eql "♕"
    end
    
    it "returns the black queen symbol" do
      @black_queen = Queen.new("black")
      expect(@black_queen.symbol).to eql "♛"
    end
  end

  context "#list_moves" do
    it "raises an error when not given a current position" do
      expect{ @queen.list_moves }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when given a current position" do
      expect{ @queen.list_moves(@initial_position)}.to_not raise_error
    end

    it "includes valid moves in all directions" do
      expect(@queen.list_moves(@initial_position)).to eql [
        @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
        @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
        @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
        @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
        @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
        @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
        @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
        @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
      ]
    end

    context "left" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[3][1].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2],                                         # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[3][1].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1],                      # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "right" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[3][6].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5],                                                            # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[3][6].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6],                                         # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "up" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[1][4].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4],                                                            # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[1][4].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4],                                         # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "down" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[6][4].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4],                                         # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[6][4].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4],                      # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "up_left" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[1][2].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3],                                                            # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[1][2].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2],                                         # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "dwn_left" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[6][1].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2],                                         # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[6][1].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1],                      # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "up_right" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[1][6].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5],                                                            # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[1][6].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6],                                         # up_right
          @board.grid[4][5], @board.grid[5][6], @board.grid[6][7]                       # dwn_right
        ]
      end
    end

    context "dwn_right" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[5][6].piece = Queen.new("black")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5],                                                            # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[5][6].piece = Queen.new("white")
        expect(@queen.list_moves(@initial_position)).to eql [
          @board.grid[3][3], @board.grid[3][2], @board.grid[3][1], @board.grid[3][0],   # left
          @board.grid[3][5], @board.grid[3][6], @board.grid[3][7],                      # right
          @board.grid[2][4], @board.grid[1][4], @board.grid[0][4],                      # up
          @board.grid[4][4], @board.grid[5][4], @board.grid[6][4], @board.grid[7][4],   # down
          @board.grid[2][3], @board.grid[1][2], @board.grid[0][1],                      # up_left
          @board.grid[4][3], @board.grid[5][2], @board.grid[6][1], @board.grid[7][0],   # dwn_left
          @board.grid[2][5], @board.grid[1][6], @board.grid[0][7],                      # up_right
          @board.grid[4][5], @board.grid[5][6]                                          # dwn_right
        ]
      end
    end

  end

end


