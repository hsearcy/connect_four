class AIHard

  def initialize(depth)
    @depth = depth
  end
  
  def pick_move(boardstatus)
   @best_value = []
    value = negamax(boardstatus, @depth, -9999999, 9999999, 1)
    @best_value
  end
  
  def negamax(boardstatus, depth, alpha, beta, color)
    player = get_player(color)
    if (depth == 0 || terminal(boardstatus))
      evaluator = Evaluation.new(boardstatus)
      return color * evaluator.evaluate(player)
    end

    max = -9999999
    legal_moves(boardstatus).each do |column|
      row = get_next_open_row(boardstatus, column)
      temp_board = Marshal.load(Marshal.dump(boardstatus))
      do_move(temp_board, column, row, player)

      winner = WinDetection.winner(temp_board, column, row, player)
      if winner == player
        negamax_value = (20000 + depth)
      else
        negamax_value = -negamax(temp_board, depth - 1, -beta, -alpha, -color)
      end

      if negamax_value > max
        max = negamax_value
        @best_value = [column, row]  if depth == @depth
      end

      alpha = [alpha, negamax_value].max
      return alpha if alpha >= beta
    end
    max
  end

  def get_top_played_row(column)
    column.each_index.select{|row| column[row] > 0 }.last
  end
  
  def legal_moves(boardstatus)
    boardstatus.each_index.select{|col| !boardstatus[col].index(0).nil? } 
  end
  
  def terminal(boardstatus)
    legal_moves(boardstatus).length == 0
  end

  def get_next_open_row(boardstatus, column)
    row = get_top_played_row(boardstatus[column])
    row = -1 if row.nil?
    row += 1
  end

  def get_player(color)
    color == 1 ? 2 : 1
  end

  def do_move(board, column, row, player)
    board[column][row] = player
  end
end
