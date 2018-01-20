class Evaluation

  def initialize(boardstatus)
    @boardstatus = boardstatus
    
  end

  def evaluate(player)
    opponent = player == 1 ? 2 : 1
    calculate_utility(player) - calculate_utility(opponent)
  end

  def calculate_utility(player)
    vertical_utility(player) + horizontal_utility(player) + top_diagonal_utility(player) + bottom_diagonal_utility(player)
  end

  def vertical_utility(player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(@boardstatus[move_col])
      next if move_row.nil?
      (1..3).each do |i| 
        break if move_row - i < 0 || @boardstatus[move_col][move_row-i] != player
        utility += 10**i
      end
    end
    utility
  end

  def horizontal_utility(player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(@boardstatus[move_col])
      next if move_row.nil?
      (1..3).each do |i| 
        if move_col + i > 6 || @boardstatus[move_col + i][move_row] != player
          break
        else
          utility += 10**i
        end
      end
    end
    utility
  end

  def top_diagonal_utility(player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(@boardstatus[move_col])
      next if move_row.nil?
      (1..3).each do |i| 
        if move_col + i > 6 || move_row - i < 0 || @boardstatus[move_col + i][move_row - i] != player
          break;
        else
          utility += 10**i
        end
      end
    end
    utility
  end

  def bottom_diagonal_utility(player)
    utility = 0
    7.times do |move_col|
      move_row = get_top_played_row(@boardstatus[move_col])
      next if move_row.nil?
      (1..3).each do |i| 
        if move_col + i > 6 || move_row + i > 5 || @boardstatus[move_col + i][move_row + i] != player
          break;
        else
          utility += 10**i
        end
      end
    end
    utility
  end

  def get_top_played_row(column)
    column.each_index.select{|row| column[row] > 0 }.last
  end
end