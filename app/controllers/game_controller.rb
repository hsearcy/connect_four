class GameController < ApplicationController
  def index
  end

  def new
    game = Game.find_by(id: params[:id]) unless params[:reset]
    game = Game.create(mode: params[:mode]) if game.nil?
    render json: game.to_json
  end

  def move
    game = Game.update_game(params[:id], params[:moveCol])
    render json: game.to_json
  end

  def computer
    game = Game.update_game_computer(params[:id])
    render json: game.to_json
  end

end
