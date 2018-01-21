class Game < ApplicationRecord
  after_initialize :set_game_defaults

  serialize :boardstatus

  def set_game_defaults
    self.boardstatus ||= Array.new(7){ Array.new(6){0} }
    self.mode ||= 1
    self.move ||= 1
  end

  def self.update_game(id, move_col)
    game = self.find(id)
    col = move_col.to_i
    row = game.boardstatus[col].index(0)
    
    unless row.nil? 
      game.boardstatus[col][row] = game.move
      game.winner = WinDetection.winner(game.boardstatus, col, row, game.move)
      if game.winner == 0
        if game.mode == 2
          ai_move = AIEasy.pick_move(game.boardstatus, col, row)
          game.boardstatus[ai_move[0]][ai_move[1]] = 2
          game.winner = ai_move[2]
        else
          game.move == 1 ? game.move = 2 : game.move = 1
        end
      end
      game.save
    end
    return game
  end

  def self.update_game_computer(id)
    game = self.find(id)
    return game if game.winner > 0
    hard_ai = AIHard.new(6)
    ai_move = hard_ai.pick_move(game.boardstatus)
    game.boardstatus[ai_move[0]][ai_move[1]] = 2
    game.winner = WinDetection.winner(game.boardstatus, ai_move[0], ai_move[1], 2)
    game.move = 1
    game.save
    return game
  end

end