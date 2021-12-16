# frozen_string_literal: true

class CheckCompleteService
  attr_reader :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    shipping_address = @order.address
    shipping_address = ShippingAddress.where(addressed: @order).first if shipping_address.is_one_table.zero?
    @order.finish! if @order.checking_complete?
    OpenStruct.new(order: @order, shipping_address: shipping_address)
  end
end
