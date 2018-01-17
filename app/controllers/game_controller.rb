class GameController < ApplicationController
  def index
  end

  def new
    game = Game.setup
    puts 'controller'
    puts game.boardstate.to_json
    render json: game.to_json
  end

  def move
    puts params[:id]
    puts params[:col]
  end
end
