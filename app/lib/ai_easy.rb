class AIEasy
  
  def self.pick_move (boardstatus, player_move_col, player_move_row)
    
    valid_moves = []

    (0..6).each do |column|
      next_row = boardstatus[column].index(0)
      next if next_row.nil?
      valid_moves.push(column)
      temp_board =  Marshal.load(Marshal.dump(boardstatus))

      temp_board[column][next_row] = 1
      if WinDetection.winner(temp_board, column, next_row, 1) == 1
        return [column, next_row, 0] 
      end

      temp_board[column][next_row] = 2
      return [column, next_row, 2] if WinDetection.winner(temp_board, column, next_row, 2) == 2
    end

    if player_move_col == 0 || player_move_col == 6
      [1,5].shuffle.each do |column|
        if valid_moves.include?(column)
          next_row = boardstatus[column].index(0)
          return [column, next_row, 0]
        end
      end
    end

    if player_move_col == 3
      [2,3,4].shuffle.each do |column|
        if valid_moves.include?(column)
          next_row = boardstatus[column].index(0)
          return [column, next_row, 0]
        end
      end
    end

    last_resort = valid_moves.sample
    return[last_resort, boardstatus[last_resort].index(0)]
  end
end