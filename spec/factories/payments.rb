# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  cvv             :integer
#  expiration_date :string
#  name            :string
#  number          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :bigint
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
FactoryBot.define do
  factory :payment do
    name { FFaker::Name.name }
    number { FFaker::PhoneNumberCU.e164_mobile_phone_number.to_s }
    expiration_date { '11/2002 ' }
    cvv { 2314 }
    order
  end
end
