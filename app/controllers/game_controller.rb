class GameController < ApplicationController
  def index
  end

  def new
    game = Game.setup
    puts 'controller'
    puts game.boardstate.to_json
    render json: game.boardstate.to_json
  end
end
