require "./lib/chess/game_logic"

RSpec.describe GameLogic do

  context "#check?" do
    it "returns false for opening board" do
      board = Board.new_full
      logic = GameLogic.new(board)
      expect(logic.check?("white")).to eql false
    end

    before do
      @board = Board.new
      @logic = GameLogic.new(@board)
      @board.grid[0][0].piece = King.new("white")
    end

    it "returns true for check by a rook" do
      @board.grid[5][0].piece = Rook.new("black")
      expect(@logic.check?("white")).to eql true
    end

    it "returns true for check by a bishop" do
      @board.grid[4][4].piece = Bishop.new("black")
      expect(@logic.check?("white")).to eql true
    end

    it "returns true for check by multiple pieces" do
      @board.grid[4][4].piece = Bishop.new("black")
      @board.grid[5][0].piece = Rook.new("black")
      expect(@logic.check?("white")).to eql true
    end
  end

  context "#list_legal_moves" do
    before do
      @board = Board.new
      @logic = GameLogic.new(@board)
      @king = King.new("white")
    end

    it "returns a list of legal moves for a king in check by a rook" do
      @board.grid[0][0].piece = @king
      @board.grid[5][0].piece = Rook.new("black")
      expect(@logic.list_legal_moves("white")).to eql ({
        @king => {
          pos_i: @board.grid[0][0],
          moves: [
            @board.grid[0][1], @board.grid[1][1]
          ]
        }
      })
    end

    it "returns a list of legal moves for a king in check by a bishop" do
      @board.grid[0][0].piece = @king
      @board.grid[4][4].piece = Bishop.new("black")
      expect(@logic.list_legal_moves("white")).to eql ({
        @king => {
          pos_i: @board.grid[0][0],
          moves: [
            @board.grid[0][1], @board.grid[1][0]
          ]
        }
      })
    end

    it "returns a list of legal moves for a king in check by multiple pieces" do
      @board.grid[0][0].piece = @king
      @board.grid[4][4].piece = Bishop.new("black")
      @board.grid[5][0].piece = Rook.new("black")
      expect(@logic.list_legal_moves("white")).to eql ({
        @king => {
          pos_i: @board.grid[0][0],
          moves: [
            @board.grid[0][1]
          ]
        }
      })
    end

    it "returns a list of legal moves for multiple pieces" do
      @board.grid[0][7].piece = King.new("black")
      @pawn = Pawn.new("white")
      @board.grid[1][3].piece = @pawn
      @rook = Rook.new("white")
      @board.grid[2][2].piece = @rook
      @board.grid[2][4].piece = @king
      @knight = Knight.new("white")
      @board.grid[4][1].piece = @knight
      @board.grid[6][0].piece = Bishop.new("black")
      @board.grid[7][5].piece = Rook.new("black")

      expect(@logic.list_legal_moves("white")).to eql ({
        @king => {
          pos_i: @board.grid[2][4],
          moves: [
            @board.grid[2][3], @board.grid[1][4], @board.grid[3][4]
          ]
        },
        @knight => {
          pos_i: @board.grid[4][1],
          moves: [
            @board.grid[3][3], @board.grid[6][0]
          ]
        },
        @rook => {
          pos_i: @board.grid[2][2],
          moves: [
            @board.grid[4][2]
          ]
        },
        @pawn => {
          pos_i: @board.grid[1][3],
          moves: []
        }
      })
    end
  end


  context "#checkmate?" do
    it "returns false for opening board" do
      board = Board.new_full
      logic = GameLogic.new(board)
      expect(logic.checkmate?("black")).to eql false
    end

    it "returns true for checkmate with a rook" do
      board = Board.new
      board.grid[7][7].piece = Rook.new("white")
      board.grid[3][5].piece = King.new("white")
      board.grid[3][7].piece = King.new("black")
      logic = GameLogic.new(board)
      expect(logic.checkmate?("black")).to eql true
    end

    it "returns true for checkmate with two bishops" do
      board = Board.new
      board.grid[7][7].piece = King.new("white")
      board.grid[5][4].piece = Bishop.new("black")
      board.grid[5][5].piece = Bishop.new("black")
      board.grid[5][7].piece = King.new("black")      
      logic = GameLogic.new(board)
      expect(logic.checkmate?("white")).to eql true
    end

    it "returns true for Fool's Mate" do
      board = Board.new_full
      board.move_piece("white", "f2", "f3")
      board.move_piece("black", "e7", "e5")
      board.move_piece("white", "g2", "g4")
      board.move_piece("black", "d8", "h4")
      logic = GameLogic.new(board)
      expect(logic.checkmate?("white")).to eql true
    end
  end

end