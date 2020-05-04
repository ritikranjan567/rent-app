class ChangeUserIdToUseridOfRequests < ActiveRecord::Migration[6.0]
  def change
    rename_column :requests, :user_id, :userid
    rename_column :notes, :user_id, :userid
  end
end
