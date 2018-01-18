class AIHard

  def initialize(depth)
    @depth = depth
  end
  
  def pick_move(boardstatus)
    @best_value = {}
    negamax(boardstatus, @depth, -9999999, 9999999, 1)
    puts "depth: #{@depth}"
    puts "best values: #{@best_value}"
    move_col = @best_value.max_by { |move, value| value }[0]
    [move_col, boardstatus[move_col].index(0)]
  end
  
  def negamax(boardstatus, depth, alpha, beta, color)
    puts "Negamax called with color = #{color}, depth = #{depth}"
    player = color == 1 ? 2 : 1
    return (color * evaluate(boardstatus, player)) if depth == 0 || terminal(boardstatus)
  
    max = -9999999
    legal_moves(boardstatus).each do |column|
      row = get_top_played_row(boardstatus[column])
      row = -1 if row.nil?
      row += 1
      temp_board =  Marshal.load(Marshal.dump(boardstatus))
      
      temp_board[column][row] = player
      negamax_value = -negamax(temp_board, depth - 1, -beta, -alpha, -color)
      
      max = [max, negamax_value].max
      @best_value[column] = max if depth == @depth
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

  def evaluate(boardstatus, player)
    utility = calculate_positive_utility(boardstatus, player) #- calculate_negative_utility(boardstatus, player)
    puts "Player = #{player}, utility = #{utility}"
    utility
  end

  def calculate_positive_utility(boardstatus, player)
    vertical_utility(boardstatus, player) +
      horizontal_utility(boardstatus, player) +
      top_diagonal_utility(boardstatus, player) +
      bottom_diagonal_utility(boardstatus, player)
  end

  def calculate_negative_utility(boardstatus, player)
    opponent = player == 1 ? 2 : 1
    1.1 * (vertical_utility(boardstatus, opponent) +
        horizontal_utility(boardstatus, opponent) +
        top_diagonal_utility(boardstatus, opponent) +
        bottom_diagonal_utility(boardstatus, opponent))
  end

  def vertical_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      (1..3).each do |i| 
        break if move_row - i < 0 || boardstatus[move_col][move_row-1] != player
        utility += 10**i
      end
    end
    utility
  end

  def horizontal_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      continue_left = true
      continue_right = true
      (1..3).each do |i| 
        if continue_left
          if move_col - i < 0 || boardstatus[move_col - i][move_row] != player
            continue_left = false
          else
            utility += 10**i
          end
        end
        if continue_right
          if move_col + i > 6 || boardstatus[move_col + i][move_row] != player
            continue_right = false
          else
            utility += 10**i
          end
        end
        break unless ( continue_left || continue_right )
      end
    end
    utility
  end

  def top_diagonal_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      continue_left = true
      continue_right = true
      (1..3).each do |i| 
        if continue_left
          if move_col - i < 0 || move_row + i > 5 || boardstatus[move_col - i][move_row + i] != player
            continue_left = false
          else
            utility += 10**i
          end
        end
        if continue_right
          if move_col + i > 6 || move_row - i < 0 || boardstatus[move_col + i][move_row - i] != player
            continue_right = false
          else
            utility += 10**i
          end
        end
        break unless ( continue_left || continue_right )
      end
    end
    utility
  end

  def bottom_diagonal_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      continue_left = true
      continue_right = true
      (1..3).each do |i| 
        if continue_left
          if move_col - i < 0 || move_row - i < 0 || boardstatus[move_col - i][move_row - i] != player
            continue_left = false
          else
            utility += 10**i
          end
        end
        if continue_right
          if move_col + i > 6 || move_row + i > 5 || boardstatus[move_col + i][move_row + i] != player
            continue_right = false
          else
            utility += 10**i
          end
        end
        break unless ( continue_left || continue_right )
      end
    end
    utility
  end
end



# def negamax(boardstatus, move_col, move_row, depth, player)
  
#   color = player == 2 ? 1 : -1
#   return (player * evaluate(boardstatus, move_col, move_row)) if depth == 0 || terminal(boardstatus)

#   next_player = player == 1 ? 2 : 1
#   bestValue = -9999999
#   legal_moves.each do |move|
#     value = -negamax(boardstatus, move_col, move_row, depth - 1, next_player)
#     bestValue = [bestValue, value].max
#   end

# end

