class AddGameData < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :move, :integer
    add_column :games, :winner, :integer
  end
end
