class AIHard

  def initialize(depth)
    @depth = depth
  end
  
  def pick_move(boardstatus)
   # @best_value = {}
   @best_value = []
    value = negamax(boardstatus, @depth, -9999999, 9999999, 1)
    puts "best values: #{@best_value}, with value = #{value}"
    # move_col = @best_value.max_by { |move, value| value }[0]
    # [move_col, boardstatus[move_col].index(0)]
    @best_value
  end
  
  def negamax(boardstatus, depth, alpha, beta, color)
    puts "Negamax called with color = #{color}, depth = #{depth}"
    player = color == 1 ? 2 : 1
    return (color * evaluate(boardstatus, player)) if (depth == 0 || terminal(boardstatus))
  
    max = -9999999
    legal_moves(boardstatus).each do |column|
      row = get_top_played_row(boardstatus[column])
      row = -1 if row.nil?
      row += 1
      temp_board =  Marshal.load(Marshal.dump(boardstatus))
      
      temp_board[column][row] = player
      negamax_value = -negamax(temp_board, depth - 1, -beta, -alpha, -color)
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
      4.times do |i| 
        break if move_row - i < 0 || boardstatus[move_col][move_row-1] != player
        utility += 10**i
      end
    end
    puts "vertical: #{utility}"
    utility
  end

  def horizontal_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      4.times do |i| 
        if move_col + i > 6 || boardstatus[move_col + i][move_row] != player
          break
        else
          utility += 10**i
        end
      end
    end
    puts "horizontal: #{utility}"
    utility
  end

  def top_diagonal_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      4.times do |i| 
        if move_col + i > 6 || move_row - i < 0 || boardstatus[move_col + i][move_row - i] != player
          break;
        else
          utility += 10**i
        end
      end
    end
    puts "top_diag: #{utility}"
    utility
  end

  def bottom_diagonal_utility(boardstatus, player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(boardstatus[move_col])
      next if move_row.nil?
      4.times do |i| 
        if move_col + i > 6 || move_row + i > 5 || boardstatus[move_col + i][move_row + i] != player
          break;
        else
          utility += 10**i
        end
      end
    end
    
    puts "bot_diag: #{utility}"
    utility
  end
end
