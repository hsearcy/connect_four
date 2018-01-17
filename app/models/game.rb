class Game < ApplicationRecord
  # id boardstate password player1 player2 mode
  attr_accessor :boardstate

  def self.setup
    game = self.create(
      boardstate: Array.new(7){ Array.new(6) }

    )
    puts 'game'
    puts game.id
    puts game.boardstate.to_json
    return game
  end
end
