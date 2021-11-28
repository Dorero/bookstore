# frozen_string_literal: true

class AddressForm < Reform::Form
  MAX_LENGTH = 50
  MAX_LENGTH_ZIP = 10
  MAX_LENGTH_PHONE = 15

  properties :first_name, :last_name, :address, :city, :country, :zip, :phone, :user_id

  validates :first_name, :last_name, :address, :city, :country, :phone, :zip, :user_id, presence: true
  validates :first_name, :last_name, :city, :address, :country, length: { maximum: MAX_LENGTH }
  validates :first_name, :last_name, :country, :city, format: { with: /[a-zA-Z]+$/, multiline: true }
  validates :address, format: { with: /[a-zA-Z0-9 ,-]+$/, multiline: true }
  validates :zip, format: { with: /[0-9-]+$/, multiline: true }, length: { maximum: MAX_LENGTH_ZIP }
  validates :phone, :validate_phone, length: { maximum: MAX_LENGTH_PHONE }

  private

  def validate_phone
    phone.slice(0, 3) == "+#{ISO3166::Country[country].country_code}" && phone =~ /^\+\d+$/
  end
end
