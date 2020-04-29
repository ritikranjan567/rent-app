class ChangeDetailsOfAssetsAndLocations < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :address, :text
    add_column :assets, :address, :text
  end
end
