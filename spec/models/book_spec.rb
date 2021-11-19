# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  price       :decimal(8, 2)
#  year        :string
#  height      :string
#  width       :string
#  depth       :string
#  materials   :string

RSpec.describe Book, type: :model do
  describe 'model relations book' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to have_many(:authors).through(:author_books) }
  end
end
