class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :country_code, :string
    add_column :users, :phone_verification_status, :boolean, default: false
  end
end
