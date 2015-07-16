class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :text

      t.timestamps null: false
    end

    add_reference :words, :player, index: true
    add_foreign_key :words, :players
  end
end
