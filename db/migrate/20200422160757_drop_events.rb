class DropEvents < ActiveRecord::Migration[6.0]
  def change
    drop_table :events
  end
end
