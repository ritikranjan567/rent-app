class ChangeBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :asset, index: true
    remove_column :bookings, :booked_asset_id, :integer
    add_reference :bookings, :request, index: true
  end
end
