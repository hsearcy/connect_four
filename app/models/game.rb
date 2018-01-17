class Game < ApplicationRecord
  serialize :boardstatus

  def self.setup
    game = self.new
    game.boardstatus = Array.new(7){ Array.new(6){0} }
    game.mode = 1
    game.move = 1
    game.save
    puts 'game'
    puts game.id
    puts game
    return game
  end
end