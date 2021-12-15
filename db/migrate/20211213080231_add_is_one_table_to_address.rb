class AddIsOneTableToAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :is_one_table, :integer, default: 0
  end
end
