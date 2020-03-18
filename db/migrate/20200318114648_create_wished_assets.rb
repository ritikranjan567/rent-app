class CreateWishedAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :wished_assets do |t|
      t.integer :asset_id
      t.references :wishlist, foreign_key: true

      t.timestamps
    end
  end
end
