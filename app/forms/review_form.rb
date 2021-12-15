# frozen_string_literal: true

class ReviewForm < Reform::Form
  MAX_LENGTH_TITLE = 80
  MAX_LENGTH_MESSAGE = 500
  VALIDATE = %r{[a-zA-Z0-9]|[!#$%&'*+-/=?^_`{|}~]$}.freeze

  properties :title, :message, :stars, :book_id, :user_id

  validates :title, :message, presence: true
  validates :title, :message, format: { with: VALIDATE, multiline: true }
  validates :title, length: { maximum: MAX_LENGTH_TITLE }
  validates :message, length: { maximum: MAX_LENGTH_MESSAGE }
end
