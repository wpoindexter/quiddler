class CreateWordVerifications < ActiveRecord::Migration
  def change
    create_table :word_verifications do |t|
      t.string :text
      t.boolean :valid_word

      t.timestamps null: false
    end
  end
end
