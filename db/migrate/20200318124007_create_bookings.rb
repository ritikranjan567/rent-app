class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.text :cancelation_msg
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
