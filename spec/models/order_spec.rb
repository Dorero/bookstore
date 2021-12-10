# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  aasm_state :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  coupon_id  :bigint
#
# Indexes
#
#  index_orders_on_coupon_id  (coupon_id)
#
RSpec.describe Order, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:coupon).optional }
    it { is_expected.to have_many(:saved_books) }
    it { is_expected.to have_many(:books) }
  end
end
