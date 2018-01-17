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

  def updateGame(game, move_col)
    move_row = game.boardstatus[move_col].find_index { |disc| disc == 0 }

    unless move_row.nil? 
      game.boardstatus[move_col][move_row] = game.move
      game.winner = checkWinner(game.boardstatus, move_col, move_row, game.move)
      game.move == 1 ? game.move = 2 : game.move = 1
      game.save
    end
    return game
  end

  def checkWinner(boardstatus, move_col, move_row, player)
    return player if checkVertical(boardstatus, move_col, player)
    
    return 0;
  end

  def checkVertical(boardstatus, move_col, player)
    return true if boardstatus[move_col].chunk{|disc| disc == player && disc }
                                        .any? { |same_player, consecutive| same_player && consecutive.count > 3 }
    false
  end
end
