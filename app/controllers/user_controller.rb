# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!

  def edit
    @billing = AddressForm.new(Billing.new)
    @shipping = AddressForm.new(Shipping.new)
    @email_form = EmailUserForm.new(current_user)
  end

  def update
    @email_form = EmailUserForm.new(current_user)
    @password_form = PasswordUserForm.new(current_user)

    if params[:edit_email] && @email_form.validate(params[:edit_email])
      current_user.skip_reconfirmation!
      @email_form.save
    end

    @password_form.save if params[:edit_password] && @password_form.validate(params[:edit_password])

    redirect_back(fallback_location: edit_user_path)
  end
end
