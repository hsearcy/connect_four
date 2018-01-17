class GameController < ApplicationController
  def index
  end

  def new
    game = Game.setup
    puts 'controller'
    puts game.to_json
    render json: game.to_json
  end

  def move
    game = Game.find(params[:id])
    puts params[:moveCol]
    puts game.to_json
    game = validateMove(game, params[:moveCol])
    render json: game.to_json
  end

  private
  def validateMove(game, move_col)
    valid_disc = game.boardstatus[move_col].find_index { |disc| disc == 0 }
    unless valid_disc.nil? 
      game.boardstatus[move_col][valid_disc] = game.move
      game.move == 1 ? game.move = 2 : game.move = 1
      game.save
    end
    return game
  end
end
