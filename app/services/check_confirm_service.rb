# frozen_string_literal: true

class CheckConfirmService
  attr_reader :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    billing_address = @order.billing_address
    shipping_address = @order.shipping_address
    shipping_address = billing_address unless billing_address.is_one_table.zero?

    OpenStruct.new(order: @order, billing_address: billing_address, shipping_address: shipping_address,
                   delivery: @order.delivery, payment: @order.payment)
  end

  def update(_data)
    @order.update(number: "##{SecureRandom.random_number(10_000)}") unless @order.number
    SavedBook.where(order: @order).update_all(status: :closed)
    @order.coupon.spent! if @order.coupon&.pre_use?
    @order.check_complete! if @order.checking_confirm?
  end
end
