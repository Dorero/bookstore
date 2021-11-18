class AddFieldsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :price, :decimal
    add_column :books, :year, :string
    add_column :books, :height, :string
    add_column :books, :width, :string
    add_column :books, :depth, :string
    add_column :books, :materials, :string
  end
end
