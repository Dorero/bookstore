# frozen_string_literal: true

# == Schema Information
#
# Table name: saved_books
#
#  id         :bigint           not null, primary key
#  price      :decimal(8, 2)
#  quantity   :integer
#  status     :integer          default("open")
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

  enum status: { open: 0, pre_order: 1, closed: 2 }
end
