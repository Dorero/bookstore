# frozen_string_literal: true

# == Schema Information
#
# Table name: saved_books
#
#  id             :bigint           not null, primary key
#  quantity_books :integer
#  total_price    :decimal(8, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  book_id        :bigint
#  order_id       :bigint
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
RSpec.describe SavedBook, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:book) }
  end
end
