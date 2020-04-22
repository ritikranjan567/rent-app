class RemoveBookingTypeFromAssets < ActiveRecord::Migration[6.0]
  def change

    remove_column :assets, :booking_type, :string
  end
end
