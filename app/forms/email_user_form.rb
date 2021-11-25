# frozen_string_literal: true

class EmailUserForm < Reform::Form
  MAXIMUM_SIZE_EMAIL = 63
  property :email

  validates :email,
            format: { with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)
|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/, multiline: true },
            length: { maximum: MAXIMUM_SIZE_EMAIL }
end
