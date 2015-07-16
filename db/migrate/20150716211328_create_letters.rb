class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :text
      t.integer :points

      t.timestamps null: false
    end
  end
end
