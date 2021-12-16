# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  cvv             :integer
#  expiration_date :string
#  name            :string
#  number          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :bigint
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
FactoryBot.define do
  factory :payment do
    name { FFaker::Name.name }
    number { FFaker::Book.description(10) }
    expiration_date { '11/2002 '}
    cvv { 2314 }
    order
  end
end
