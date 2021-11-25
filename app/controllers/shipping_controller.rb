# frozen_string_literal: true

class ShippingController < ApplicationController
  def update
    @shipping = AddressForm.new(Shipping.new)
    return redirect_to(controller: :user, action: :edit) unless @shipping.validate(params[:shipping])

    @shipping.save
  end
end
