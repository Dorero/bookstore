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
RSpec.describe SavedBook, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:book) }
  end
end
