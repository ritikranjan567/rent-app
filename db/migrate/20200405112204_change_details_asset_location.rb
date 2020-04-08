class ChangeDetailsAssetLocation < ActiveRecord::Migration[6.0]
  def change
    remove_reference(:locations, :asset, index: true, foreign_key: true)
    add_reference(:assets, :location, index: true, foreign_key: true)
    add_column :assets, :currency, :string
  end
end
