# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  address    :string           not null
#  city       :string           not null
#  zip        :string           not null
#  country    :string           not null
#  phone      :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :address do
    type { 'billing' }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    country { FFaker::Address.country }
    zip { FFaker::AddressDE.zip_code }
    phone { FFaker::PhoneNumberDE.international_mobile_phone_number.gsub(' ', '') }
  end
end
