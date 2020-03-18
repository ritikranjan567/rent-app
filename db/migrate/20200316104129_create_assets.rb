class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :name
      t.integer :price
      t.string :payment_period
      t.string :dimension
      t.text :description
      t.string :rentable_duration
      t.string :event_tags
      t.string :booking_type
      t.boolean :available

      t.timestamps
    end
  end
end
