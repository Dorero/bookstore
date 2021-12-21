# frozen_string_literal: true

class CheckConfirmService
  attr_reader :message

  LIMIT_RANDOM_NUMBER = 10_000
  CheckConfirm = Struct.new(:order, :billing_address, :shipping_address, :delivery, :payment)
  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    billing_address = @order.billing_address
    shipping_address = @order.shipping_address
    shipping_address = billing_address unless billing_address.is_one_table.zero?

    CheckConfirm.new(@order, billing_address, shipping_address, @order.delivery, @order.payment)
  end

  def update(_data)
    @order.update(number: "##{SecureRandom.random_number(LIMIT_RANDOM_NUMBER)}") unless @order.number
    SavedBook.where(order: @order).each { |book| book.update(status: :closed) }
    @order.coupon.spent! if @order.coupon&.pre_use?
    @order.update(completed_at: Time.zone.now)
    @order.check_complete! if @order.checking_confirm?
  end
end
