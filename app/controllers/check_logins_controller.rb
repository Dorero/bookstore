# frozen_string_literal: true

class CheckLoginsController < Devise::RegistrationsController
  def check
    @user = build_resource
  end

  def quick_register
    email = params[:user][:email]
    return redirect_to check_check_login_path, alert: I18n.t(:account_exist) if User.exists?(email: email)

    setup_user(email)
    redirect_to check_address_checking_path, alert: I18n.t(:'devise.sessions.signed_in')
  end

  def login
    user = User.find_by_email(params[:user][:email])
    unless user && check_password(user.encrypted_password)
      return redirect_to check_check_login_path, alert: I18n.t(:'devise.failure.invalid', authentication_keys: 'email')
    end

    sign_in user
    setup_cart(user.id)
    redirect_to check_address_checking_path, alert: I18n.t(:'devise.sessions.signed_in')
  end

  private

  def check_password(encrypted_password)
    encrypted_password == BCrypt::Engine.hash_secret(params[:user][:password], encrypted_password)
  end

  def setup_cart(user_id)
    cart = Order.find(session[:current_cart])
    cart.update(user_id: user_id)
    cart.check_address!
  end

  def setup_user(email)
    user = User.create(email: email, password: Devise.friendly_token[0, 20])
    user.skip_confirmation!
    user.send_reset_password_instructions
    sign_in user
    setup_cart(user.id)
  end
end
