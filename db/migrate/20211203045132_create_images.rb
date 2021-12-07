class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.text :image_data, null: false
      t.belongs_to :book, foreign_key: true
      t.timestamps
    end
  end
end
