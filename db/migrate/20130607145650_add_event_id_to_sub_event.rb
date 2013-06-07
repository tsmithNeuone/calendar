class AddEventIdToSubEvent < ActiveRecord::Migration
  def change
    add_column :sub_events, :event_id, :integer
  end
end
