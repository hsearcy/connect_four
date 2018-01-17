class Game < ApplicationRecord
  serialize :boardstatus

  def self.setup
    game = self.new
    game.boardstatus = Array.new(7){ Array.new(6){0} }
    game.move = 1
    game.save
    return game
  end

  def self.updateGame(id, move_col)
    game = self.find(id)
    move_row = game.boardstatus[move_col].find_index { |disc| disc == 0 }

    unless move_row.nil? 
      game.boardstatus[move_col][move_row] = game.move
      game.winner = WinDetection.is_winner?(game.boardstatus, move_col, move_row, game.move)
      game.move == 1 ? game.move = 2 : game.move = 1
      game.save
    end
    return game
  end

end