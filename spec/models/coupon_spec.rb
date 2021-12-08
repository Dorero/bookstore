# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id         :bigint           not null, primary key
#  discount   :decimal(8, 2)
#  number     :string
#  status     :integer          default("ready")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Coupon, type: :model do
  describe 'model relations' do
    it { is_expected.to have_one(:order) }
  end
end
