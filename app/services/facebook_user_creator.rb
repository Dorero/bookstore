# frozen_string_literal: true

class FacebookUserCreator
  def initialize(data)
    name = data.info.name.split(' ')
    @first_name = name.first
    @last_name = name.last
    @provider = data.provider
    @uid = data.uid
    @email = data.info.email
    @image = data.info.image
    @password = data.password
  end

  def create
    User.where(provider: @provider, uid: @uid).first_or_create do |user|
      user.first_name = @first_name
      user.last_name = @last_name
      user.provider = @provider
      user.uid = @uid
      user.email = @email
      user.image = @image
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
