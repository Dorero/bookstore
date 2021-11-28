# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def update
      current_user.skip_reconfirmation!
      current_user.email = params[:user][:email].downcase
      current_user.valid?
      check_errors(current_user.errors[:email])
    end

    private

    def check_errors(errors)
      return redirect_to(edit_setting_path(errors_email: errors.uniq)) unless errors.empty?

      current_user.save(validate: false)
      redirect_to(edit_setting_path(success_change_email: I18n.t(:'devise.mailer.email_changed.subject')))
    end
  end
end
