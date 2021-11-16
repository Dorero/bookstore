class AddFieldsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :price, :decimal
    add_column :books, :year, :string
    add_column :books, :dimensions, :string
    add_column :books, :materials, :string
  end
end
