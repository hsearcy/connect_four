class AIHard
  
  def self.pick_move (boardstatus, player_move_col, player_move_row)
    
  end

  def self.evaluate(boardstate, move_col, move_row)
    self.calculate_positive_utility(boardstate, move_col, move_row) -
      self.calculate_negative_utility(boardstate, move_col, move_row)
  end

  def self.calculate_positive_utility(boardstate, move_col, move_row)
    self.vertical_utility(boardstatus, move_col, move_row, 2) +
      self.horizontal_utility(boardstatus, move_col, move_row, 2) +
      self.top_diagonal_utility(boardstatus, move_col, move_row, 2) +
      self.bottom_diagonal_utility(boardstatus, move_col, move_row, 2)
  end

  def self.calculate_negative_utility(boardstate, move_col, move_row)
    self.vertical_utility(boardstatus, move_col, move_row, 1) +
      self.horizontal_utility(boardstatus, move_col, move_row, 1) +
      self.top_diagonal_utility(boardstatus, move_col, move_row, 1) +
      self.bottom_diagonal_utility(boardstatus, move_col, move_row, 1)
  end

  def self.vertical_utility(boardstatus, move_col, move_row, player)
    utility = 0
    (1..3).each do |i| 
      break if move_row - i < 0 || boardstatus[move_col - i][move_row] != player
      utilility += 10**(i-1)
    end
    utility
  end

  def self.horizontal_utility(boardstatus, move_col, move_row, player)
    utility = 0
    continue_left = true
    continue_right = true
    (1..3).each do |i| 
      if continue_left
        if move_col - i < 0 || boardstatus[move_col - i][move_row] != player
          continue_left = false
        else
          utilility += 10**(i-1)
        end
      end
      if continue_right
        if move_col + i > 6 || boardstatus[move_col + i][move_row] != player
          continue_right = false
        else
          utilility += 10**(i-1)
        end
      end
      break unless ( continue_left || continue_right )
    end
    utility
  end

  def self.top_diagonal_utility(boardstatus, move_col, move_row, player)
    utility = 0
    continue_left = true
    continue_right = true
    (1..3).each do |i| 
      if continue_left
        if move_col - i < 0 || move_row + i > 5 || boardstatus[move_col - i][move_row + i] != player
          continue_left = false
        else
          utilility += 10**(i-1)
        end
      end
      if continue_right
        if move_col + i > 6 || move_row - i < 0 || boardstatus[move_col + i][move_row - i] != player
          continue_right = false
        else
          utilility += 10**(i-1)
        end
      end
      break unless ( continue_left || continue_right )
    end
    utility
  end

  def self.bottom_diagonal_utility(boardstatus, move_col, move_row, player)
    utility = 0
    continue_left = true
    continue_right = true
    (1..3).each do |i| 
      if continue_left
        if move_col - i < 0 || move_row - i < 0 || boardstatus[move_col - i][move_row - i] != player
          continue_left = false
        else
          utilility += 10**(i-1)
        end
      end
      if continue_right
        if move_col + i > 6 || move_row + i > 5 || boardstatus[move_col + i][move_row + i] != player
          continue_right = false
        else
          utilility += 10**(i-1)
        end
      end
      break unless ( continue_left || continue_right )
    end
    utility
  end
end

#successors = legal_moves.each do { |move| boardstate[move]} 
#terminal_test = legal_moves.empty

#argmax(successors.boardstates, )
