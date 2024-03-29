# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = FacebookUserCreator.new(request.env['omniauth.auth']).create
      @user.confirm
      CartService.new(nil, nil, session[:current_cart]).add_user(@user.id) if session[:current_cart]
      auth_action(@user)
    end

    def failure
      redirect_to root_path
    end

    private

    def auth_action(user)
      if user.persisted?
        sign_in_and_redirect user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      else
        session['devise.facebook_data'] = request.env['omniauth.auth'].except(:extra)
        redirect_to new_user_registration_url
      end
    end
  end
end
