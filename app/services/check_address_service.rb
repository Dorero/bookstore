# frozen_string_literal: true

class CheckAddressService
  attr_reader :address, :errors, :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    addresses = setup_addresses
    billing_address_form = AddressForm.new(addresses[:billing_address])
    shipping_address_form = AddressForm.new(addresses[:shipping_address])
    OpenStruct.new(billing_address: billing_address_form, shipping_address: shipping_address_form, order: @order)
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
      @address = address
      return false
    end
    form.save
  end

  def setup_addresses
    user = User.find(@user_id)
    shipping_address = ShippingAddress.where(addressed: user).first || ShippingAddress.new
    billing_address = BillingAddress.where(addressed: user).first || BillingAddress.new
    if @order.address
      billing_address = @order.address
      shipping_address = billing_address
      shipping_address = ShippingAddress.where(addressed: @order).first if billing_address.is_one_table.zero?
    end

    { billing_address: billing_address, shipping_address: shipping_address }
  end
end
