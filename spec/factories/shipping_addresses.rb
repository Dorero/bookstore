# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  city       :string           not null
#  country    :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  phone      :string           not null
#  type       :string           not null
#  zip        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :shipping_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    country { FFaker::Address.country }
    zip { FFaker::AddressDE.zip_code }
    phone { FFaker::PhoneNumberDE.international_mobile_phone_number.gsub(' ', '') }
  end
end
