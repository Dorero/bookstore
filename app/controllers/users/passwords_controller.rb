# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    skip_before_action :require_no_authentication, only: [:update]

    def update
      current_user.password = params[:user][:password]
      current_user.valid?
      check_errors(current_user.errors[:password])
    end

    private

    def check_errors(errors)
      return current_user.save(validate: false) if errors.empty?

      redirect_to(edit_setting_path(errors_password: errors.uniq))
    end
  end
end
