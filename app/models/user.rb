# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, length: { maximum: 63}
  validates :password, format: { with: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/, :multiline => true }

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    UserCreator.new(auth).create
  end
end
