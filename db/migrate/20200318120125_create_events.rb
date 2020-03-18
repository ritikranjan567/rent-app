class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.text :description
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
