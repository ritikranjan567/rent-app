class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.text :content
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
