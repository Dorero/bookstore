# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  canceled_at  :datetime
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
FactoryBot.define do
  factory :order do
    status { 'cart' }
    number { "##{SecureRandom.random_number(10_000)}" }
    user
    delivery
    coupon
    trait :with_all_tables do
      billing_address
      shipping_address
      delivery
    end
  end
end
