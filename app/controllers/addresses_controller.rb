# frozen_string_literal: true

class AddressesController < ApplicationController
  def update
    service = CheckAddressService.new(current_user.id, session[:current_cart])
    service.update(params[:address][:billing_address], params[:address][:shipping_address])
    path_after_update(service)
  end

  private

  def path_after_update(service)
    if service.errors
      flash[:alert] = errors_to_string(service.errors)
      return redirect_back(fallback_location: edit_setting_path)
    end

    flash[:alert] = I18n.t(:addresses_saved)
    redirect_back(fallback_location: edit_setting_path)
  end

  def errors_to_string(errors)
    prepare_errors(errors).reduce('') { |string, error| string + "#{error.first.tr('_', ' ')}: #{error.last}. " }
  end
end
