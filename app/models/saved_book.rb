# frozen_string_literal: true

# == Schema Information
#
# Table name: saved_books
#
#  id         :bigint           not null, primary key
#  price      :decimal(8, 2)
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  order_id   :bigint
#
# Indexes
#
#  index_saved_books_on_book_id   (book_id)
#  index_saved_books_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (order_id => orders.id)
#
class SavedBook < ApplicationRecord
  belongs_to :order
  belongs_to :book
end
