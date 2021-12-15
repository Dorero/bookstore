class CreateSavedBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_books do |t|
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.belongs_to :book, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.timestamps
    end
  end
end
