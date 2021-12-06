class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.string :type, null: false
      t.integer :status, default: 0
      t.string :number
      t.timestamps
    end
  end
end
