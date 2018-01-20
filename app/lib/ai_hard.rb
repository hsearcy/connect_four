class AIHard

  def initialize(depth)
    @depth = depth
  end
  
  def pick_move(boardstatus)
   # @best_value = {}
   @best_value = []
    value = negamax(boardstatus, -1, -1, @depth, -9999999, 9999999, 1)
    puts "best values: #{@best_value}, with value = #{value}"
    # move_col = @best_value.max_by { |move, value| value }[0]
    # [move_col, boardstatus[move_col].index(0)]
    @best_value
  end
  
  def negamax(boardstatus, move_col, move_row, depth, alpha, beta, color)
    puts "Negamax called with color = #{color}, depth = #{depth}"
    player = color == 1 ? 2 : 1
    return (color * evaluate(boardstatus, move_col, move_row, player)) if (depth == 0 || terminal(boardstatus))
  
    max = -9999999
    legal_moves(boardstatus).each do |column|
      row = get_top_played_row(boardstatus[column])
      row = -1 if row.nil?
      row += 1
      temp_board =  Marshal.load(Marshal.dump(boardstatus))
      
      temp_board[column][row] = player
      negamax_value = -negamax(temp_board, column, row, depth - 1, -beta, -alpha, -color)
      puts "negamax_value #{negamax_value}"
      if negamax_value > max
        max = negamax_value
        @best_value = [column, row]  if depth == @depth
      end
      
      # max = [max, negamax_value].max
      # @best_value[column] = max if depth == @depth
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

  def evaluate(boardstatus, column, row, player)
    utility = calculate_positive_utility(boardstatus, column, row, player) #- calculate_negative_utility(boardstatus, player)
    puts "Player = #{player}, column = #{column}, row = #{row}, utility = #{utility}"
    utility
  end

  def calculate_positive_utility(boardstatus, column, row, player)
    vertical_utility(boardstatus, column, row, player) +
      horizontal_utility(boardstatus, column, row, player) +
      top_diagonal_utility(boardstatus, column, row, player) +
      bottom_diagonal_utility(boardstatus, column, row, player)
  end

  def calculate_negative_utility(boardstatus, player)
    opponent = player == 1 ? 2 : 1
    1.1 * (vertical_utility(boardstatus, column, row, player) +
        horizontal_utility(boardstatus, column, row, player) +
        top_diagonal_utility(boardstatus, column, row, player) +
        bottom_diagonal_utility(boardstatus, column, row, player))
  end

  def vertical_utility(boardstatus, column, row, player)
    utility = 1
    (1..3).each do |i| 
      break if row - i < 0 || boardstatus[column][row-1] != player
      utility += 10**i
    end
    puts "vertical: #{utility}"
    utility #Might need to mod this since its not multiplied?
  end

  def horizontal_utility(boardstatus, column, row, player)
    left_utility = 1
    right_utility = 1
    continue_left = true
    continue_right = true
    (1..3).each do |i| 
      if continue_left
        if column - i < 0 || boardstatus[column - i][row] != player
          continue_left = false
        else
          left_utility += 10**(i-1)
        end
      end
      if continue_right
        if column + i > 6 || boardstatus[column + i][row] != player
          continue_right = false
        else
          right_utility += 10**(i-1)
        end
      end
      break unless ( continue_left || continue_right )
    end
    utility = left_utility * right_utility
    puts "horizontal: #{utility}"
    utility
  end

  def top_diagonal_utility(boardstatus, column, row, player)
    left_utility = 1
    right_utility = 1
    continue_left = true
    continue_right = true
    (1..3).each do |i| 
      if continue_left
        if column - i < 0 || row + i > 5 || boardstatus[column - i][row + i] != player
          continue_left = false
        else
          left_utility += 10**(i-1)
        end
      end
      if continue_right
        if column + i > 6 || row - i < 0 || boardstatus[column + i][row - i] != player
          continue_right = false
        else
          right_utility += 10**(i-1)
        end
      end
      break unless ( continue_left || continue_right )
    end
    utility = left_utility * right_utility
    puts "top_diag: #{utility}"
    utility
  end

  def bottom_diagonal_utility(boardstatus, column, row, player)
    left_utility = 1
    right_utility = 1
    continue_left = true
    continue_right = true
    (1..3).each do |i| 
      if continue_left
        if column - i < 0 || row + i > 5 || boardstatus[column - i][row - i] != player
          continue_left = false
        else
          left_utility += 10**(i-1)
        end
      end
      if continue_right
        if column + i > 6 || row - i < 0 || boardstatus[column + i][row + i] != player
          continue_right = false
        else
          right_utility += 10**(i-1)
        end
      end
      break unless ( continue_left || continue_right )
    end
    utility = left_utility * right_utility
    puts "bot_diag: #{utility}"
    utility
  end
end
