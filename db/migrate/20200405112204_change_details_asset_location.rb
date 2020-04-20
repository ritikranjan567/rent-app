class ChangeDetailsAssetLocation < ActiveRecord::Migration[6.0]
  def change
    remove_reference(:locations, :asset, index: true, foreign_key: true)
    add_reference(:assets, :location, index: true, foreign_key: true)
    add_column :assets, :currency, :string
    add_column :locations, :pincode, :string
    change_column :assets, :available, :boolean, default: true
    remove_column :assets, :rentable_duration, :string
  end
end
