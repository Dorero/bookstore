# frozen_string_literal: true

class AddressesController < ApplicationController
  def update
    service = CheckAddressService.new(current_user.id, session[:current_cart])
    service.update(params[:billing_address], params[:shipping_address])
    path_after_update(service)
  end

  private

  def path_after_update(service)
    return redirect_to(edit_setting_path(prepare_errors(service.errors))) if service.errors

    flash[:alert] = I18n.t(:address_success_save, address_name: service.address)
    redirect_back(fallback_location: edit_setting_path)
  end
end
