# frozen_string_literal: true

class PaymentForm < Reform::Form
  MAX_LENGTH_NAME = 50
  MIN_LENGTH_CARD_NUMBER = 10
  MIN_LENGTH_EXPIRATION_DATE = 5
  MIN_LENGTH_CVV = 3
  MAX_LENGTH_CVV = 5
  VALIDATE_NUMBER_CARD = /^\d+$/.freeze
  VALIDATION_NAME_ON_CARD = /^[a-zA-Z ]+$/.freeze
  VALIDATE_DATE = /[a-zA-Z0-9 ,-]+$/.freeze

  properties :name, :number, :expiration_date, :cvv, validates: { presence: true }
  property :order_id

  validates :name, format: { with: VALIDATION_NAME_ON_CARD, multiline: true }, length: { maximum: MAX_LENGTH_NAME }
  validates :number, format: { with: VALIDATE_NUMBER_CARD, multiline: true },
                     length: { minimum: MIN_LENGTH_CARD_NUMBER }
  validates :cvv, length: { in: MIN_LENGTH_CVV...MAX_LENGTH_CVV }
  validates :expiration_date, :validate_expiration_date, length: { minimum: MIN_LENGTH_EXPIRATION_DATE }

  private

  def validate_expiration_date
    errors.add(:expiration_date, I18n.t(:invalid_expiration_date)) unless expiration_date.include?('/')

    dates = expiration_date.split('/')
    month = dates.first.to_i
    errors.add(:expiration_date, I18n.t(:invalid_month)) if month <= 0 || month > 12
    expiration_date
  end
end
