# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    skip_before_action :require_no_authentication, only: %i[update edit]

    def update
      set_resource
      resource.password = params[:user][:password]
      resource.valid?
      check_errors
    end

    private

    def check_errors
      if resource.errors[:password].empty?
        resource.save(validate: false)
        sign_out resource
        return redirect_to(new_user_session_path, alert: I18n.t(:'devise.passwords.updated'))
      end

      error_route
    end

    def set_resource
      return self.resource = current_user unless resource_params[:reset_password_token].nil?

      token = Devise.token_generator.digest(User, :reset_password_token, resource_params[:reset_password_token])
      self.resource = User.find_by_reset_password_token(token)
      resource.reset_password_token = token
    end

    def error_route
      return respond_with(resource) if resource_params[:reset_password_token].nil?

      redirect_to(edit_setting_path(errors_password: resource.errors[:password].uniq))
    end
  end
end
