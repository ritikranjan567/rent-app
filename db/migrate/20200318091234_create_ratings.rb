class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.text :feedback
      t.integer :user_id, unique: true, index: true
      t.references :asset, foreign_key: true

      t.timestamps
    end
  end
end
