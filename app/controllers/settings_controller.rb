# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @billing_address = AddressForm.new(BillingAddress.new)
    @shipping_address = AddressForm.new(ShippingAddress.new)
  end
end
