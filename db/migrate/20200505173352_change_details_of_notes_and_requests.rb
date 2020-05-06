class ChangeDetailsOfNotesAndRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :userid, :integer
    add_reference :requests, :requestor, foreign_key: { to_table: :users }
    remove_column :notes, :userid, :integer
    add_reference :notes, :user, index: true
  end
end
