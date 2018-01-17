class GameController < ApplicationController
  def index
  end

  def new
    game = Game.setup
    render json: game.to_json
  end

  def move
    game = Game.updateGame(params[:id], params[:moveCol])
    render json: game.to_json
  end

end
