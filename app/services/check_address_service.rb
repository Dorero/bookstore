# frozen_string_literal: true

class CheckAddressService
  attr_reader :address, :errors, :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    billing_address = @order.billing_address || @order.user.billing_address || BillingAddress.new
    shipping_address = @order.shipping_address || @order.user.shipping_address || BillingAddress.new
    shipping_address = billing_address unless billing_address.is_one_table.zero?
    OpenStruct.new(billing_address: AddressForm.new(billing_address),
                   shipping_address: AddressForm.new(shipping_address), order: @order)
  end

  def update(billing_address_data, shipping_address_data)
    billing_address = BillingAddress.find_or_initialize_by(addressed_id: billing_address_data[:addressed_id])
    billing_form = AddressForm.new(billing_address)
    return unless check_address(billing_form, billing_address_data, :billing_address_errors)

    if billing_address_data[:is_one_table].to_i.zero?
      shipping_address = ShippingAddress.find_or_initialize_by(addressed_id: shipping_address_data[:addressed_id])
      shipping_form = AddressForm.new(shipping_address)
      return unless check_address(shipping_form, shipping_address_data, :shipping_address_errors)
    end

    @order.check_delivery! if @order.checking_address?
  end

  private

  def check_address(form, value, address)
    unless form.validate(value)
      @errors = form.errors
      p @errors
      @address = address
      return false
    end
    form.save
  end
end
