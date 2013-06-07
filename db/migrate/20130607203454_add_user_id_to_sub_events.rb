class AddUserIdToSubEvents < ActiveRecord::Migration
  def change
    add_column :sub_events, :user_id, :integer
  end
end
