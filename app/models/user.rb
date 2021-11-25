# frozen_string_literal: true

class User < ApplicationRecord
  MINIMUM_SIZE_PASSWORD = 8
  MAXIMUM_SIZE_EMAIL = 63

  validates :email, :password, presence: true
  validates :email, format: { with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/, multiline: true },
            length: { maximum: MAXIMUM_SIZE_EMAIL}, uniqueness: true
  validates :password, format: { with: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/, multiline: true },
            length: { minimum: MINIMUM_SIZE_PASSWORD }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

end
