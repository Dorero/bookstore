class CreateUserBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_books do |t|
      t.belongs_to :user
      t.belongs_to :book
      t.timestamps
    end
  end
end
