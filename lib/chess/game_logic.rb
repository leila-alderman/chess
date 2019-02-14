# The GameLogic class checks for check and checkmate.

class GameLogic

  def initialize(board)
    @board = board
  end

  def valid_start?(color, start)
    pos_i = @board.grid.flatten.find { |square| square.name == start }
    # Reject move if that position doesn't exist.
    if pos_i.nil?
      puts "Invalid move: Please enter a position between a1 and h8."
      return false
    end
    piece = pos_i.piece
    # Reject move if no piece exists at the start position.
    if piece.nil?
      puts "Invalid move: There is no piece at that position." 
      return false
    end
    # Reject move if the piece is a different color than the player.
    if piece.color != color
      puts "Invalid move: You can only move pieces of your own color." 
      return false
    end
    return true
  end

  def valid_move?(color, start, stop)
    pos_i = @board.grid.flatten.find { |square| square.name == start }
    piece = pos_i.piece
    pos_f = @board.grid.flatten.find { |square| square.name == stop }
    # Reject move if that position doesn't exist.
    if pos_f.nil?
      puts "Invalid move: Please enter a position between a1 and h8."
      return false
    end
    total_move_list = list_legal_moves(color)
    piece_move_list = total_move_list[piece][:moves]
    # Reject move if the stop position is not in the move list.
    unless piece_move_list.include?(pos_f)
      puts "Invalid move: That piece cannot move to that position." 
      return false
    end
    return true
  end

  # The check? method is given the color of a player and returns `true` if that player is in check.
  def check?(color)
    # Find the position of that player's king.
    king_pos = @board.grid.flatten.find{|square| square.piece.class == King && square.piece.color == color}
    # Find the positions of all of the opponent's pieces.
    current_positions = @board.grid.flatten.select { |square| !square.piece.nil? && square.piece.color != color }
    # Create a move list that contains all possible moves of the current player.
    total_move_list = []
    current_positions.each do |square|
      curr_piece = square.piece
      move_list = curr_piece.list_moves(square)
      total_move_list += move_list
    end
    # Check whether the position of the king is in the total move list.
    return total_move_list.include?(king_pos)
  end

  # The list_legal_moves method creates a hash of all the legal moves a player can make.
  # It removes any moves that would place or leave the king in danger.
  def list_legal_moves(color)
    # Find all of the pieces of the given color.
    current_positions = @board.grid.flatten.select { |square| !square.piece.nil? && square.piece.color == color }
    # Generate a hash of all of the moves that each piece can take.
    total_moves = {}
    current_positions.each do |position|
      piece = position.piece
      move_list = piece.list_moves(position)
      total_moves[piece] = {pos_i: position, moves: move_list}
    end
    # Iterate through the hash, and for each piece:
    #   1) Record its initial position.
    #   2) For each move in its move list:
    #       a) Save the piece that is currently located at the move position.
    #       b) Move the piece from its initial position to the move position.
    #       c) Determine whether making this move will result in check for the current player.
    #       d) Reset the pieces at the initial position and the move position 
    #           back to their state before making the move.
    #       e) If the move doesn't result in check, keep the move; otherwise, delete the move.
    total_moves.each do |piece, values|
      pos_i = values[:pos_i]
      legal_moves = values[:moves].select do |pos_f|
        piece_f = pos_f.piece

        # Pass the Board#move_piece method the names of the start and stop positions.
        @board.move_piece(color, pos_i.name, pos_f.name)
        check?(color) ? valid = false : valid = true

        pos_f.piece = piece_f
        pos_i.piece = piece
        valid
      end
      values[:moves] = legal_moves
    end
    return total_moves
  end

  # The checkmate? method is given the color of a player and returns `true` if that player is in checkmate.
  # A checkmate is defined as a player having no legal moves and being in check.
  def checkmate?(color)
    total_moves = list_legal_moves(color)
    total_move_list = []
    total_moves.each do |piece, values|
      total_move_list += values[:moves]
    end
    total_move_list == [] && check?(color) ? true : false
  end

  # The stalemate? method is given the color of a player and returns `true` if that player is in a stalemate.
  # A stalemate is defined as a player having no legal moves and not being in check.
  def stalemate?(color)
    total_moves = list_legal_moves(color)
    total_move_list = []
    total_moves.each do |piece, values|
      total_move_list += values[:moves]
    end
    total_move_list == [] && !check?(color) ? true : false  
  end
end
