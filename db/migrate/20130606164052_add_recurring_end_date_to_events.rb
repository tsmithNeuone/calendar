class AddRecurringEndDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurring_ends_at, :date
  end
end
