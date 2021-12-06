# frozen_string_literal: true

# == Schema Information
#
# Table name: sale_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  sale_id    :bigint
#
# Indexes
#
#  index_sale_books_on_book_id  (book_id)
#  index_sale_books_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (sale_id => sales.id)
#
FactoryBot.define do
  factory :sale_book do
    sale
    book
  end
end
