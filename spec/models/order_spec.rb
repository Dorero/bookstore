# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  completed_at :datetime
#  delivered_at :datetime
#  number       :string
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  coupon_id    :bigint
#  delivery_id  :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_orders_on_coupon_id    (coupon_id)
#  index_orders_on_delivery_id  (delivery_id)
#  index_orders_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (delivery_id => deliveries.id)
#  fk_rails_...  (user_id => users.id)
#
RSpec.describe Order, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:coupon).optional }
    it { is_expected.to belong_to(:delivery).optional }
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
    it { is_expected.to have_one(:payment) }
    it { is_expected.to have_many(:saved_books) }
    it { is_expected.to have_many(:books) }
  end
end
