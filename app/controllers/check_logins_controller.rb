# frozen_string_literal: true

class CheckLoginsController < Devise::RegistrationsController
  before_action :permit_params

  def show
    @user = build_resource
  end

  def quick_register
    email = params[:user][:email]
    return redirect_to check_login_path, alert: I18n.t(:account_exist) if User.exists?(email: email)

    setup_user(email)
    redirect_to check_address_checking_path, alert: I18n.t(:'devise.sessions.signed_in')
  end

  def login
    user = User.find_by_email(params[:user][:email])
    unless user&.valid_password?(params[:user][:password])
      return redirect_to check_login_path, alert: I18n.t(:'devise.failure.invalid', authentication_keys: 'email')
    end

    setup_cart(user)
    redirect_to check_address_checking_path, alert: I18n.t(:'devise.sessions.signed_in')
  end

  private

  def setup_cart(user)
    sign_in user
    cart = Order.find(session[:current_cart])
    cart.update(user_id: user.id)
    cart.check_address!
  end

  def setup_user(email)
    user = User.create(email: email, password: Devise.friendly_token[0, 20])
    user.skip_confirmation!
    user.send_reset_password_instructions
    setup_cart(user)
  end

  def permit_params
    params.permit(:authenticity_token, user: %i[email password])
  end
end
