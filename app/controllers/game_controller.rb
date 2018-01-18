class GameController < ApplicationController
  def index
  end

  def new
    game = Game.find_by(id: params[:id]) unless params[:reset]
    puts "GAME #{game}, parms: #{params[:id]}"
    game = Game.create(mode: params[:mode]) if game.nil?
    render json: game.to_json
  end

  def move
    game = Game.updateGame(params[:id], params[:moveCol])
    render json: game.to_json
  end

end
