class AddBookedAssetIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :booked_asset_id, :integer, index: true
  end
end
