# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @billing_address = AddressForm.new(BillingAddress.find_or_initialize_by(addressed_id: current_user.id))
    @shipping_address = AddressForm.new(ShippingAddress.find_or_initialize_by(addressed_id: current_user.id))
  end
end
