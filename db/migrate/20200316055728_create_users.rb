class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phone_number
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
