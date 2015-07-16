class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :scorekeeper, default: false

      t.timestamps null: false
    end

    add_reference :players, :game, index: true
    add_foreign_key :players, :games
  end
end
