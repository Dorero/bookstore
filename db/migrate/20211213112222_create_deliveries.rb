class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.decimal :price, precision: 8, scale: 2
      t.integer :min_duration_delivery
      t.integer :max_duration_delivery
      t.timestamps
    end
  end
end
