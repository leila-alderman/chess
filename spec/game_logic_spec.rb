require "./lib/chess/game_logic"

RSpec.describe GameLogic do
  
  context "#valid_start?" do
    before do
      @full_board = Board.new_full
      @logic = GameLogic.new(@full_board)
    end

    it "returns false if start position is not on board" do
      expect(@logic.valid_start?("white", "z10")).to eql false
    end

    it "returns false if no piece at start position" do
      expect(@logic.valid_start?("white", "c5")).to eql false
    end

    it "returns false if piece is different color than player" do
      expect(@logic.valid_start?("black", "c2")).to eql false
    end

    it "returns true for a valid white start" do
      expect(@logic.valid_start?("white", "c2")).to eql true
    end

    it "returns true for a valid black start" do
      expect(@logic.valid_start?("black", "c7")).to eql true
    end

  end

  context "#valid_move?" do
    before do
      @full_board = Board.new_full
      @logic = GameLogic.new(@full_board)
    end
    
    it "returns false if stop position is not on board" do
      expect(@logic.valid_move?("white", "c2", "z10")).to eql false
    end
    
    it "returns false if stop position is not in move list" do
      expect(@logic.valid_move?("white", "c2", "b3")).to eql false
    end

    it "returns true for a valid pawn move" do
      expect(@logic.valid_move?("white", "c2", "c4")).to eql true
    end

    it "returns true for a valid queen move" do
      @full_board.move_piece("white", "e2", "e4")
      expect(@logic.valid_move?("white", "d1", "h5")).to eql true
    end

    it "returns true for a capture move" do
      @full_board.move_piece("white", "e2", "e4")
      @full_board.move_piece("black", "h7", "h5")
      expect(@logic.valid_move?("white", "d1", "h5")).to eql true
    end
  end  
  
  context "#check?" do
    it "returns false for opening board" do
      full_board = Board.new_full
      logic = GameLogic.new(full_board)
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

  context "#stalemate?" do
    it "returns true for example 1" do
      board = Board.new
      board.grid[0][7].piece = King.new("black")
      board.grid[1][5].piece = King.new("white")
      board.grid[2][6].piece = Queen.new("white")
      logic = GameLogic.new(board)
      expect(logic.stalemate?("black")).to eql true
    end

    it "returns true for example 2" do
      board = Board.new
      board.grid[3][0].piece = King.new("black")
      board.grid[2][2].piece = Queen.new("white")
      board.grid[4][2].piece = King.new("white")
      logic = GameLogic.new(board)
      expect(logic.stalemate?("black")).to eql true
    end

    it "returns true for example 3" do
      board = Board.new
      board.grid[7][0].piece = King.new("black")
      board.grid[6][1].piece = Rook.new("white")
      board.grid[5][2].piece = King.new("white")
      logic = GameLogic.new(board)
      expect(logic.stalemate?("black")).to eql true
    end
  end

end