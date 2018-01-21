class Evaluation

  def initialize(boardstatus)
    @boardstatus = boardstatus
    @utility = {}
    @continue = {}
  end

  def evaluate(player)
    opponent = player == 1 ? 2 : 1
    calculate_utility(player) - calculate_utility(opponent)
  end

  def calculate_utility(player)
    [:vertical, :horizontal, :top_diagonal, :bot_diagonal].each { |key| @utility[key] = 0 }
    7.times do |column|
      [:vertical, :horizontal, :top_diagonal, :bot_diagonal].each { |key| @continue[key] = true }
      row = get_top_played_row(@boardstatus[column])
      next if row.nil?
      (1..3).each do |i|
        eval_vertical_utility(player, column, row, i) if @continue[:vertical]
        eval_horizontal_utility(player, column, row, i) if @continue[:horizontal]
        eval_top_diagonal_utility(player, column, row, i) if @continue[:top_diagonal]
        eval_bot_diagonal_utility(player, column, row, i) if @continue[:bot_diagonal]
      end
    end
    @utility.values.reduce(:+)
  end

  def eval_vertical_utility(player, column, row, i)
    if row - i < 0 || @boardstatus[column][row - i] != player
      @continue[:vertical] = false
    else
      @utility[:vertical] += 10**i 
    end
  end 

  def eval_horizontal_utility(player, column, row, i)
   if column + i > 6 || @boardstatus[column + i][row] != player
    @continue[:horizontal] = false
   else
    @utility[:horizontal] += 10**i 
   end
  end 

  def eval_top_diagonal_utility(player, column, row, i)
    if column + i > 6 || row - i < 0 || @boardstatus[column + i][row - i] != player
      @continue[:top_diagonal] = false
    else
      @utility[:top_diagonal] += 10**i 
    end
  end 

  def eval_bot_diagonal_utility(player, column, row, i)
    if column + i > 6 || row + i < 5 || @boardstatus[column + i][row + i] != player
      @continue[:bot_diagonal] = false
    else
      @utility[:bot_diagonal] += 10**i 
    end
  end 
  
  def get_top_played_row(column)
    column.each_index.select{|row| column[row] > 0 }.last
  end
end