# frozen_string_literal: true

# == Schema Information
#
# Table name: author_books
#
#  id         :bigint           not null, primary key
#  author_id  :bigint
#  book_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe AuthorBook, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:book) }
  end
end
