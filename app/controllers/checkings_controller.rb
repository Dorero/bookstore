# frozen_string_literal: true

class CheckingsController < ApplicationController
  before_action :authenticate_user!

  def show
    service = setup_service
    instances = service.show
    return path_when_exception(service.message) if service.message

    setup_instance(instances)
    render(template: "checkings/checkout_#{order_state}")
  end

  def update
    service = setup_service
    service.update(params)
    return path_when_exception(service.message) if service.message

    redirect_to checking_path
  end

  private

  def path_when_exception(message)
    flash[:alert] = message
    redirect_back(fallback_location: checking_path)
  end

  def order_state
    Order.find(session[:current_cart]).aasm.current_state.to_s.split('_').last
  end

  def setup_instance(instances)
    instances.each { |name, instance| instance_variable_set("@#{name}", instance) }
  end

  def setup_service
    "Check#{order_state.capitalize}Service".constantize.new(current_user.id, session[:current_cart])
  end
end
