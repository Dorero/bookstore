# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  image                  :string
#  last_name              :string           default(""), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  MINIMUM_SIZE_PASSWORD = 8
  MAXIMUM_SIZE_EMAIL = 63
  VALIDATE_EMAIL = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)
|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/.freeze
  VALIDATE_PASSWORD = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/.freeze

  validates :email, :password, presence: true
  validates :email,
            format: {
              with: VALIDATE_EMAIL, multiline: true
            },
            length: { maximum: MAXIMUM_SIZE_EMAIL }, uniqueness: true
  validates :password, format: { with: VALIDATE_PASSWORD, multiline: true },
                       length: { minimum: MINIMUM_SIZE_PASSWORD }

  has_one :address, dependent: :destroy
  has_many :reviews, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]
end
