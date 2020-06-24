class RenameRequestedPriceOfRequests < ActiveRecord::Migration[6.0]
  def change
    rename_column :requests, :requested_price, :requested_price_info
  end
end
