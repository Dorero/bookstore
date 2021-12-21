# frozen_string_literal: true

class AddressForm < Reform::Form
  MAX_LENGTH = 50
  MAX_LENGTH_ZIP = 10
  MAX_LENGTH_PHONE = 15
  VALIDATE_PHONE = /^\+\d+$/.freeze
  VALIDATE_ZIP = /[0-9-]+$/.freeze
  VALIDATE_ADDRESS = /[a-zA-Z0-9 ,-]+$/.freeze
  GENERAL_VALIDATE = /[a-zA-Z]+$/.freeze

  properties :first_name, :last_name, :address, :city, :country, :zip, :phone, :addressed_id, :addressed_type,
             validates: { presence: true }
  property :is_one_table, optional: true

  validates :first_name, :last_name, :city, :address, :country, length: { maximum: MAX_LENGTH }
  validates :first_name, :last_name, :country, :city, format: { with: GENERAL_VALIDATE, multiline: true }
  validates :address, format: { with: VALIDATE_ADDRESS, multiline: true }
  validates :zip, format: { with: VALIDATE_ZIP, multiline: true }, length: { maximum: MAX_LENGTH_ZIP }
  validates :phone, :validate_phone, length: { maximum: MAX_LENGTH_PHONE }

  private

  def validate_phone
    country_code = ISO3166::Country[country].country_code
    phone_by_country = "+#{phone.slice(1, country_code.length)}" == "+#{country_code}" && phone =~ VALIDATE_PHONE
    errors.add(:phone_not_by_country, I18n.t(:phone_not_by_country)) unless phone_by_country
    phone
  end
end
