require "./lib/chess/player"
require "./lib/chess/board"

RSpec.describe Player do

  context "#initialize" do
    it "requires input" do
      expect { Player.new }.to raise_error(ArgumentError)
    end

    it "requires two parameters" do
      expect{ Player.new("Bob")}.to raise_error(ArgumentError)
    end

    it "initializes with valid input" do
      expect{ Player.new("Bob", "white")}.to_not raise_error
    end
  end

  before do
    @player = Player.new("Laura", "white")
  end

  context "#name" do
    it "returns the name" do
      expect(@player.name).to eql "Laura"
    end

    it "can't change the name" do
      expect { @player.name = "Bob" }.to raise_error(NoMethodError)
    end
  end

  context "#color" do
    it "returns the color" do
      expect(@player.color).to eql "white"
    end

    it "can't change the color" do
      expect { @player.color = "black" }.to raise_error(NoMethodError)
    end
  end

  context "#move" do
    before do
      @board = Board.new
      @board.setup_pieces
    end

    it "raises an error if not given any input" do
      expect{ @player.move }.to raise_error(ArgumentError)
    end

    it "raises an error if given too few arguments" do
      expect{ @player.move(@board, "a3")}.to raise_error(ArgumentError)
    end

    it "doesn't raise an error if given three arguments" do
      expect{ @player.move(@board, "a3", "c4")}.to_not raise_error
    end

    it "rejects move if no piece at start position" do
      expect(@player.move(@board, "c5", "c4")).to eql "Invalid move: There is no piece at the start position."
    end

    it "rejects move if piece is different color than player" do
      expect(@player.move(@board, "d7", "d6")).to eql "Invalid move: You can only move pieces of your own color."
    end

    it "rejects move if stop position is not in move list" do
      expect(@player.move(@board, "c2", "b3")).to eql "Invalid move: That piece cannot move to that position."
    end

    it "can move a pawn" do
      @player.move(@board, "c2", "c4")
      expect(@board.grid[4][2].piece.is_a? Pawn).to eql true
    end

    it "can move a queen" do
      @player.move(@board, "e2", "e4")
      @player.move(@board, "d1", "h5")
      expect(@board.grid[3][7].piece.color).to eql "white"
    end
  end

end