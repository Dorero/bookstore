# frozen_string_literal: true

class CheckCompleteService
  attr_reader :message

  CheckComplete = Struct.new(:order, :shipping_address)

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    shipping_address = @order.billing_address.is_one_table.zero? ? @order.shipping_address : @order.billing_address
    @order.bought! if @order.checking_complete?
    CheckComplete.new(@order, shipping_address)
  end
end
