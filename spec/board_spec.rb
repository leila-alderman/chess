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

  context "#left" do
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

  context "#right" do
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

  context "#up" do
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

  context "#down" do
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

  context "#up_left" do
    it "can access squares to the upper left" do
      expect(@board.grid[3][3].up_left).to equal @board.grid[2][2]
    end

    it "can access squares farther to the upper left" do
      expect(@board.grid[2][2].up_left.up_left).to equal @board.grid[0][0]
    end
  end

  context "#dwn_left" do
    it "can access squares to the lower left" do
      expect(@board.grid[3][3].dwn_left).to equal @board.grid[4][2]
    end

    it "can access squares farther to the lower left" do
      expect(@board.grid[2][5].dwn_left.dwn_left).to equal @board.grid[4][3]
    end
  end

  context "#up_right" do
    it "can access squares to the upper right" do
      expect(@board.grid[4][0].up_right).to equal @board.grid[3][1]
    end

    it "can access squares farther to the upper right" do
      expect(@board.grid[5][2].up_right.up_right).to equal @board.grid[3][4]
    end
  end

  context "#dwn_right" do
    it "can access squares to the lower right" do
      expect(@board.grid[3][3].dwn_right).to equal @board.grid[4][4]
    end

    it "can access squares farther to the lower right" do
      expect(@board.grid[2][0].dwn_right.dwn_right).to equal @board.grid[4][2]
    end
  end

end