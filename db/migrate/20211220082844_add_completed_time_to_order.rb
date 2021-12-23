class AddCompletedTimeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :completed_at, :datetime
  end
end
