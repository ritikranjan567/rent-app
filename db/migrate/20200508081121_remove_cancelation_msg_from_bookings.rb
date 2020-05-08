class RemoveCancelationMsgFromBookings < ActiveRecord::Migration[6.0]
  def change

    remove_column :bookings, :cancelation_msg, :text
  end
end
