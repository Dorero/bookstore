class UserController < ApplicationController
  before_action :authenticate_user!

  def edit
    @billing = AddressForm.new(Billing.new)
    @shipping = AddressForm.new(Shipping.new)
  end

  def update
    @user = User.all.find(params[:id])
  end
end
