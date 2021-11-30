# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  type       :string
#  first_name :string
#  last_name  :string
#  address    :string
#  city       :string
#  zip        :string
#  country    :string
#  phone      :string
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :billing_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    country { FFaker::Address.country }
    zip { FFaker::AddressDE.zip_code }
    phone { FFaker::PhoneNumberDE.international_mobile_phone_number.gsub(' ', '') }
  end
end
