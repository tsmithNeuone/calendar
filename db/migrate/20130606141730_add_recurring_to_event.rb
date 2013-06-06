class AddRecurringToEvent < ActiveRecord::Migration
  def change
    add_column :events, :recurring, :string
    add_column :events, :ignore_holidays, :boolean
  end
end
