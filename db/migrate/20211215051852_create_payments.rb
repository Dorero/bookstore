class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :number
      t.string :expiration_date
      t.integer :cvv
      t.belongs_to :order, foreign_key: true
      t.timestamps
    end
  end
end
