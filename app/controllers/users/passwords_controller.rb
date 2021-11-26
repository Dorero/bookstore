# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    skip_before_action :require_no_authentication, only: [:update]

    # GET /resource/password/new

    # POST /resource/password

    # GET /resource/password/edit?reset_password_token=abcdef

    # PUT /resource/password
    def update
      current_user.password = params[:user][:password]
      return current_user.save(validate: false) if current_user.valid? || current_user.errors[:password].empty?

      redirect_to(edit_setting_path(errors_password: current_user.errors[:password].uniq))
    end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  end
end
