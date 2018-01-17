class GameController < ApplicationController
  def index
  end

  def new
    game = Game.setup
    render json: game.to_json
  end

  def move
    game = Game.find(params[:id])
    game = updateGame(game, params[:moveCol])
    render json: game.to_json
  end

  private
  #Move all this logic out of the controller when done
  def updateGame(game, move_col)
    move_row = game.boardstatus[move_col].find_index { |disc| disc == 0 }

    unless move_row.nil? 
      game.boardstatus[move_col][move_row] = game.move
      game.winner = is_winner?(game.boardstatus, move_col, move_row, game.move)
      game.move == 1 ? game.move = 2 : game.move = 1
      game.save
    end
    return game
  end

  def is_winner?(boardstatus, move_col, move_row, player)
    return player if (  vertical_win(boardstatus, move_col, player) || 
                        horizontal_win(boardstatus, move_col, move_row, player) ||
                        left_top_diagonal_win(boardstatus, move_col, move_row, player) ||
                        right_top_diagonal_win(boardstatus, move_col, move_row, player)
                      )
    
    return 0;
  end

  def vertical_win(boardstatus, move_col, player)
    puts "HEY"
    puts boardstatus[move_col].chunk{|disc| disc == player && disc }
    .any? { |same_player, consecutive| same_player && consecutive.count > 3 }
    return true if boardstatus[move_col].chunk{|disc| disc == player && disc }
                                        .any? { |same_player, consecutive| same_player && consecutive.count > 3 }
    false
  end

  def horizontal_win(boardstatus, move_col, move_row, player)
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
      puts (left_matches + right_matches)
      return true if (left_matches + right_matches) > 2
      return false unless ( continue_left || continue_right )
    end
    return false
  end

  def left_top_diagonal_win(boardstatus, move_col, move_row, player)
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
      puts (left_matches + right_matches)
      return true if (left_matches + right_matches) > 2
      return false unless ( continue_left || continue_right )
    end
    return false
  end

  def right_top_diagonal_win(boardstatus, move_col, move_row, player)
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
      puts (left_matches + right_matches)
      return true if (left_matches + right_matches) > 2
      return false unless ( continue_left || continue_right )
    end
    return false
  end
end
