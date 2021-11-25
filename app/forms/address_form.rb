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
  validates :first_name, :last_name, :country, :city, format: { with: /[a-zA-Z]/ }
  validates :address, format: { with: /[a-zA-Z0-9 ,-]/ }
  validates :zip, format: { with: /[0-9-]/ }, length: { maximum: 10 }
  validates :phone, format: { with: /[+0-9]/ }, length: { maximum: 15 }
end
