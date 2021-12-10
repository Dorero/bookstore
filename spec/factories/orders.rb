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
FactoryBot.define do
  factory :order do
    aasm_state { 'cart' }
    coupon
  end
end
