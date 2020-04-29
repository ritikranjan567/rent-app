class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :item, polymorphic: true
      t.boolean :viewed, :default => false

      t.timestamps
    end
  end
end
