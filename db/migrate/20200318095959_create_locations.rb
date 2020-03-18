class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.float :longitude
      t.float :latitude
      t.string :place
      t.string :city
      t.string :address
      t.references :asset, foreign_key: true

      t.timestamps
    end
  end
end
