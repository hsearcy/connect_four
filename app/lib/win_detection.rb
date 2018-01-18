class WinDetection
  def self.winner (boardstatus, move_col, move_row, player)
    return player if (  self.vertical_win(boardstatus, move_col, player) || 
                        self.horizontal_win(boardstatus, move_col, move_row, player) ||
                        self.left_top_diagonal_win(boardstatus, move_col, move_row, player) ||
                        self.right_top_diagonal_win(boardstatus, move_col, move_row, player)
                      )
    
    return 0;
  end

  def self.vertical_win(boardstatus, move_col, player)
    # puts "verticals:"
    # boardstatus[move_col].chunk{|disc| disc == player && disc }.each { |num, ary| p [num, ary.count] }
    # puts "end"
    return true if boardstatus[move_col].chunk{|disc| disc == player && disc }
                                        .any? { |same_player, consecutive| same_player && consecutive.count > 3 }
    false
  end

  def self.horizontal_win(boardstatus, move_col, move_row, player)
    continue_left = true
    continue_right = true
    left_matches = 0
    right_matches = 0
    (1..3).each do |i| 
      if continue_left
        if move_col - i < 0 || boardstatus[move_col - i][move_row] != player
          continue_left = false
        else
          left_matches += 1
        end
      end
      if continue_right
        if move_col + i > 6 || boardstatus[move_col + i][move_row] != player
          continue_right = false
        else
          right_matches += 1
        end
      end
      return true if (left_matches + right_matches) > 2
      return false unless ( continue_left || continue_right )
    end
    return false
  end

  def self.left_top_diagonal_win(boardstatus, move_col, move_row, player)
    continue_left = true
    continue_right = true
    left_matches = 0
    right_matches = 0
    (1..3).each do |i| 
      if continue_left
        if move_col - i < 0 || move_row + i > 5 || boardstatus[move_col - i][move_row + i] != player
          continue_left = false
        else
          left_matches += 1
        end
      end
      if continue_right
        if move_col + i > 6 || move_row - i < 0 || boardstatus[move_col + i][move_row - i] != player
          continue_right = false
        else
          right_matches += 1
        end
      end
      return true if (left_matches + right_matches) > 2
      return false unless ( continue_left || continue_right )
    end
    return false
  end

  def self.right_top_diagonal_win(boardstatus, move_col, move_row, player)
    continue_left = true
    continue_right = true
    left_matches = 0
    right_matches = 0
    (1..3).each do |i| 
      if continue_left
        if move_col - i < 0 || move_row - i < 0 || boardstatus[move_col - i][move_row - i] != player
          continue_left = false
        else
          left_matches += 1
        end
      end
      if continue_right
        if move_col + i > 6 || move_row + i > 5 || boardstatus[move_col + i][move_row + i] != player
          continue_right = false
        else
          right_matches += 1
        end
      end
      return true if (left_matches + right_matches) > 2
      return false unless ( continue_left || continue_right )
    end
    return false
  end
end