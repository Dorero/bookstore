# frozen_string_literal: true

class CheckAddressService
  attr_reader :address, :errors, :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
  end

  def show
    order = Order.find(@order_id)
    billing_address_instance = BillingAddress.where(addressed: order).first
    shipping_address_instance = ShippingAddress.where(addressed: order).first
    billing_address_instance ||= BillingAddress.find_or_initialize_by(addressed_id: @user_id)
    shipping_address_instance ||= ShippingAddress.find_or_initialize_by(addressed_id: @user_id)

    billing_address = AddressForm.new(billing_address_instance)
    shipping_address = AddressForm.new(shipping_address_instance)

    { billing_address: billing_address, shipping_address: shipping_address, order: order }
  end

  def update(billing_address_data, shipping_address_data)
    if shipping_address_data
      shipping_form = AddressForm.new(ShippingAddress.find_or_initialize_by(addressed_id: shipping_address_data[:addressed_id]))
      return check_address(shipping_form, shipping_address_data, :shipping_address_errors)
    end
    billing_form = AddressForm.new(BillingAddress.find_or_initialize_by(addressed_id: billing_address_data[:addressed_id]))
    check_address(billing_form, billing_address_data, :billing_address_errors) if billing_address_data
  end

  private

  def check_address(form, value, address)
    @address = address.to_s.split('_').first.capitalize
    unless form.validate(value)
      @errors = { "#{address}": form.errors }
      return false
    end

    order = Order.find(@order_id)
    order.check_delivery! if order.checking_address?
    form.save
  end
end
