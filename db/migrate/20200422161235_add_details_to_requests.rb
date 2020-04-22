class AddDetailsToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :event_name, :string
    add_column :requests, :event_description, :text
    add_column :requests, :event_start_date, :date 
    add_column :requests, :event_end_date, :date
  end
end
