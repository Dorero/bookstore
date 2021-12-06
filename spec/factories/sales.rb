# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id             :bigint           not null, primary key
#  number         :string
#  quantity_books :integer
#  status         :integer          default("wait")
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :sale do
    type { 'Cart' }
    number { FFaker::PhoneNumber.imei }
  end
end
