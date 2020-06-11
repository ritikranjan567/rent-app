class AddRequestedPriceToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :requested_price, :string
  end
end
