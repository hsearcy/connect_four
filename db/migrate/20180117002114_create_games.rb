class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :boardstate
      t.string :password
      t.string :player1
      t.string :player2
      t.integer :mode
      t.integer :move
      t.integer :winner

      t.timestamps
    end
  end
end
