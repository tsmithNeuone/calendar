class AddNotifyToEvent < ActiveRecord::Migration
  def change
    add_column :events, :notify_contacts, :boolean
  end
end
