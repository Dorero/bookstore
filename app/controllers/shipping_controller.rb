class ShippingController < ApplicationController
  def update
    @shipping = AddressForm.new(Shipping.new)
    return redirect_to(controller: :user, action: :edit, errors: @shipping.errors) unless @shipping.validate(params[:shipping])

    @shipping.save
  end
end
