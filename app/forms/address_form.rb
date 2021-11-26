# frozen_string_literal: true

class AddressForm < Reform::Form
  property :first_name
  property :last_name
  property :address
  property :country
  property :city
  property :phone
  property :zip

  validates :first_name, :last_name, :address, :city, :country, :phone, :zip, presence: true
  validates :first_name, :last_name, :city, :address, :country, length: { maximum: 50 }
  validates :first_name, :last_name, :country, :city, format: { with: /[a-zA-Z]+$/, multiline: true }
  validates :address, format: { with: /[a-zA-Z0-9 ,-]+$/, multiline: true }
  validates :zip, format: { with: /[0-9-]+$/, multiline: true }, length: { maximum: 10 }
  validates :phone, format: { with: /^\+\d+$/, multiline: true }, length: { maximum: 15 }
end
