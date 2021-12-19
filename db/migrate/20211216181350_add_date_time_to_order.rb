class AddDateTimeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :canceled_at, :datetime
  end
end
