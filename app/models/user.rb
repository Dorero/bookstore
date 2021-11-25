# frozen_string_literal: true

class User < ApplicationRecord
  has_one :address

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    name = auth.info.name.split(' ')
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = name.first
      user.last_name = name.last
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.image = auth.info.image
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
