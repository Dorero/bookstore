class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :number, default: SecureRandom.hex
      t.integer :discount, default: SecureRandom.random_number(20)
      t.integer :status, default: 0
      t.belongs_to :sale, foreign_key: true
      t.timestamps
    end
  end
end
