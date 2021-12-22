# frozen_string_literal: true

class CheckingsController < ApplicationController
  before_action :authenticate_user!

  BACK_TO_STATES = { 'address' => :back_to_address!, 'delivery' => :back_to_delivery!,
                     'payment' => :back_to_payment! }.freeze

  def show
    service = setup_service
    instances = service.show
    return path_when_exception(service.message) if service.message

    render(template: "checkings/checkout_#{order_state}", locals: { instances: instances })
  end

  def update
    service = setup_service
    service.update(params)
    return redirect_to books_path if Order.find(session[:current_cart]).complete?
    return path_when_exception(service.message) if service.message

    redirect_to checking_path
  end

  private

  def path_when_exception(message)
    flash[:alert] = message
    redirect_back(fallback_location: checking_path)
  end

  def order_state
    order = Order.find(session[:current_cart])
    order.public_send(BACK_TO_STATES[params[:state]]) if BACK_TO_STATES.key?(params[:state]) && order.checking_confirm?
    order.aasm.current_state.to_s.split('_').last
  end

  def setup_service
    "Check#{order_state.capitalize}Service".constantize.new(current_user.id, session[:current_cart])
  end
end
