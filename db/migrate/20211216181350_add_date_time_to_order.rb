class AddDateTimeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :completed, :datetime
  end
end
