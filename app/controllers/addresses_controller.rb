# frozen_string_literal: true

class AddressesController < ApplicationController
  def update
    check_value(AddressForm.new(BillingAddress.new), params[:billing_address], :billing_address_errors)
    check_value(AddressForm.new(ShippingAddress.new), params[:shipping_address], :shipping_address_errors)
  end

  private

  def check_value(form, value, address)
    return unless value

    return redirect_to(edit_setting_path("#{address}": prepare_data(form.errors))) unless form.validate(value)

    form.save
  end

  def prepare_data(errors)
    errors.each_with_object({}) { |error, memo| memo[error.attribute.to_s] = error.message }
  end
end
