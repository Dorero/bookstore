# frozen_string_literal: true

class PasswordUserForm < Reform::Form
  MINIMUM_SIZE_PASSWORD = 8

  property :password
  validates :password, format: { with: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/, multiline: true },
                       length: { minimum: MINIMUM_SIZE_PASSWORD }
end
