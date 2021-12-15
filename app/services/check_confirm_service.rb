# frozen_string_literal: true

class CheckConfirmService
  attr_reader :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    billing_address = BillingAddress.where(addressed: @order).first
    shipping_address = billing_address
    shipping_address = ShippingAddress.where(addressed: @order).first if billing_address.is_one_table.zero?

    { order: @order, billing_address: billing_address, shipping_address: shipping_address, delivery: @order.delivery,
      payment: @order.payment }
  end

  def update(data); end
end
