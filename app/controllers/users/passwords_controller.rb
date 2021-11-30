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
      if errors.empty?
        current_user.save(validate: false)
        return redirect_to(new_user_session_path, alert: I18n.t(:'devise.passwords.updated'))
      end

      redirect_to(edit_setting_path(errors_password: errors.uniq))
    end
  end
end
