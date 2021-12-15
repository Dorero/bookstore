class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.integer :number
      t.string :expiration_date
      t.integer :cvv
      t.timestamps
    end
  end
end
