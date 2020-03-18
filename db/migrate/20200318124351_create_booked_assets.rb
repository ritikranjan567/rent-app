class CreateBookedAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :booked_assets do |t|
      t.integer :asset_id
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
