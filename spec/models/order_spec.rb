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
RSpec.describe Order, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:coupon).optional }
    it { is_expected.to have_many(:saved_books) }
    it { is_expected.to have_many(:books) }
  end
end
