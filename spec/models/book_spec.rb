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
#  price       :decimal(, )
#  year        :string
#  dimensions  :string
#  materials   :string
#
RSpec.describe Book, type: :model do
  describe 'model relations book' do
    it { is_expected.to belong_to(:category) }
  end
end
