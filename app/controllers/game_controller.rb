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
    puts game.to_json
    puts params[:moveCol]
    validateMove(game, params[:moveCol])
    render json: game.to_json
  end

  private
  def validateMove(game, move_col)
    valid_disc = game.boardstate[move_col].find_index { |disc| disc == 0 }
    unless valid_disc.nil? 

    end
  end
end
