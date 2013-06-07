class CreateSubEvents < ActiveRecord::Migration
  def change
    create_table :sub_events do |t|
      t.string :title
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day
      t.string :description
      t.boolean :notify_contacts

      t.timestamps
    end
  end
end
