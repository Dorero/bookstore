# frozen_string_literal: true

class CheckDeliveryService
  attr_reader :message

  CheckDelivery = Struct.new(:order, :deliveries)

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
  end

  def show
    CheckDelivery.new(@order, Delivery.all)
  end

  def update(data)
    return @message = I18n.t(:necessary_select_delivery) unless data[:delivery][:id]

    @order.update(delivery_id: data[:delivery][:id])
    @order.check_payment! if @order&.checking_delivery?
  end
end
