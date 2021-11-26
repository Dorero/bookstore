# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  image                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  provider               :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  confirmation_sent_at   :datetime
#
class User < ApplicationRecord
  MINIMUM_SIZE_PASSWORD = 8
  MAXIMUM_SIZE_EMAIL = 63

  validates :email, :password, presence: true
  validates :email,
            format: {
              with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A
-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/, multiline: true
            },
            length: { maximum: MAXIMUM_SIZE_EMAIL }, uniqueness: true
  validates :password, format: { with: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/, multiline: true },
                       length: { minimum: MINIMUM_SIZE_PASSWORD }

  has_one :address

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth); end
end
