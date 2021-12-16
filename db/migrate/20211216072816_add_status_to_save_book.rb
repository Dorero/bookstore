class AddStatusToSaveBook < ActiveRecord::Migration[6.1]
  def change
    add_column :saved_books, :status, :integer, default: 0
  end
end
