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
#  user_id    :bigint
#
# Indexes
#
#  index_orders_on_coupon_id  (coupon_id)
#  index_orders_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :order do
    aasm_state { 'cart' }
    coupon
  end
end
