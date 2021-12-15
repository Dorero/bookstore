# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id             :bigint           not null, primary key
#  address        :string           not null
#  addressed_type :string
#  city           :string           not null
#  country        :string           not null
#  first_name     :string           not null
#  is_one_table   :integer          default(0)
#  last_name      :string           not null
#  phone          :string           not null
#  type           :string           not null
#  zip            :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  addressed_id   :bigint
#
# Indexes
#
#  index_addresses_on_addressed  (addressed_type,addressed_id)
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
