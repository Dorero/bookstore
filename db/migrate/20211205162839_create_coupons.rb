class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :number
      t.decimal :discount, precision: 8, scale: 2
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
