class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.belongs_to :coupon, null: true
      t.timestamps
    end
  end
end
