class Game < ApplicationRecord
  attr_accessor :boardstate

  def self.setup
    game = self.new
    game.boardstate = 'b'#Array.new(7){ Array.new(6){0} }.to_json
    game.mode = 1
    game.move = 1
    game.save
    puts 'game'
    puts game.id
    puts game
    return game
  end
end
