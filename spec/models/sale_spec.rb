# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id             :bigint           not null, primary key
#  number         :string
#  quantity_books :integer
#  status         :integer          default(0)
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
RSpec.describe Sale, type: :model do
  describe 'model relations' do
    it { is_expected.to have_one(:address) }
    it { is_expected.to have_one(:coupon) }
    it { is_expected.to have_many(:sale_books) }
    it { is_expected.to have_many(:books) }
  end
end
