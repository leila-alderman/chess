require "./lib/chess/bishop"
require "./lib/chess/board"

RSpec.describe Bishop do

  context "#initialize" do
    it "raises an error when initialized without a color" do
      expect{ Bishop.new }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when initialized with a color" do
      expect { Bishop.new("white")}.to_not raise_error
    end

  end

  before do
    @bishop = Bishop.new("black")
    @board = Board.new
    @initial_position = @board.grid[3][3]
  end

  context "#color" do
    it "can return the color" do
      expect(@bishop.color).to eql "black"
    end

    it "cannot be changed" do
      expect{@bishop.color = "white" }.to raise_error(NoMethodError)
    end
  end

  context "#list_moves" do
    it "raises an error when not given a current position" do
      expect{ @bishop.list_moves }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error when given a current position" do
      expect{ @bishop.list_moves(@initial_position)}.to_not raise_error
    end

    it "includes valid moves in all directions" do
      expect(@bishop.list_moves(@initial_position)).to eql [
        @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
        @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
        @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
        @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
      ]
    end

    context "up_left" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[1][1].piece = Bishop.new("black")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2],                                                            # up_left
          @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
          @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[1][1].piece = Bishop.new("white")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1],                                         # up_left
          @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
          @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
        ]
      end
    end

    context "dwn_left" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[5][1].piece = Bishop.new("black")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
          @board.grid[4][2],                                                            # dwn_left
          @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[5][1].piece = Bishop.new("white")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
          @board.grid[4][2], @board.grid[5][1],                                         # dwn_left
          @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
        ]
      end
    end

    context "up_right" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[1][5].piece = Bishop.new("black")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
          @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
          @board.grid[2][4],                                                            # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[1][5].piece = Bishop.new("white")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
          @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
          @board.grid[2][4], @board.grid[1][5],                                         # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6], @board.grid[7][7]    # dwn_right
        ]
      end
    end

    context "dwn_right" do
      it "stops before squares occupied by a piece of the same color" do
        @board.grid[6][6].piece = Bishop.new("black")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
          @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
          @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
          @board.grid[4][4], @board.grid[5][5]                                          # dwn_right
        ]
      end

      it "stops in squares occupied by a piece of a different color" do
        @board.grid[6][6].piece = Bishop.new("white")
        expect(@bishop.list_moves(@initial_position)).to eql [
          @board.grid[2][2], @board.grid[1][1], @board.grid[0][0],                      # up_left
          @board.grid[4][2], @board.grid[5][1], @board.grid[6][0],                      # dwn_left
          @board.grid[2][4], @board.grid[1][5], @board.grid[0][6],                      # up_right
          @board.grid[4][4], @board.grid[5][5], @board.grid[6][6]                       # dwn_right
        ]
      end
    end
  end

end