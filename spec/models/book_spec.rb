# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  depth       :string
#  description :text
#  height      :string
#  image       :string
#  materials   :string
#  name        :string
#  price       :decimal(8, 2)
#  width       :string
#  year        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#
# Indexes
#
#  index_books_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

RSpec.describe Book, type: :model do
  describe 'model relations book' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to have_many(:authors).through(:author_books) }
  end
end
