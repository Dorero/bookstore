class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :message
      t.string :stars
      t.string :status, default: 'Unprocessed'
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :book, foreign_key: true, null: false
      t.timestamps
    end
  end
end
