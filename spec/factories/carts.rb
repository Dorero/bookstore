# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id             :bigint           not null, primary key
#  number         :string
#  quantity_books :integer
#  status         :integer          default(0)
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :cart do
    number { FFaker::PhoneNumber.imei }
  end
end
