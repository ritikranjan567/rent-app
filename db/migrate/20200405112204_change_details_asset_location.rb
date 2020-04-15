class ChangeDetailsAssetLocation < ActiveRecord::Migration[6.0]
  def change
    remove_reference(:locations, :asset, index: true, foreign_key: true)
    add_reference(:assets, :location, index: true, foreign_key: true)
    add_column :assets, :currency, :string
    change_column :locations, :address, :text
    remove_column :locations, :city, :string
    add_column :locations, :pincode, :string
  end
end
