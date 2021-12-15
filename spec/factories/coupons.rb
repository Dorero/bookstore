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
FactoryBot.define do
  factory :coupon do
    number { FFaker::PhoneNumber.imei }
    discount { rand(30) }
    status { :ready }
  end
end
