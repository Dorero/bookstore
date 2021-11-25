# frozen_string_literal: true

class BillingController < ApplicationController
  def update
    @billing = AddressForm.new(Billing.new)
    return redirect_to(controller: :user, action: :edit) unless @billing.validate(params[:billing])

    @billing.save
  end
end
