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
#
RSpec.describe Book, type: :model do
  describe 'model relations' do
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to have_many(:authors).through(:author_books) }
  end
end
