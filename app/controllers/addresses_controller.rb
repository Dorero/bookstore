# frozen_string_literal: true

class AddressesController < ApplicationController
  def update
    check_address(AddressForm.new(BillingAddress.new), params[:billing_address], :billing_address_errors)
    check_address(AddressForm.new(ShippingAddress.new), params[:shipping_address], :shipping_address_errors)
  end

  private

  def check_address(form, value, address)
    return unless value

    return redirect_to(edit_setting_path("#{address}": prepare_errors(form.errors))) unless form.validate(value)

    form.save
    redirect_to(edit_setting_path,
                alert: I18n.t(:address_success_save, address_name: address.to_s.split('_').first.capitalize))
  end
end
