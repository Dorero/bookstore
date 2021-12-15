# frozen_string_literal: true

class CheckDeliveryService
  attr_reader :message

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
  end

  def show
    order = Order.find(@order_id)
    check_addresses(order)
    deliveries = Delivery.all
    { order: order, deliveries: deliveries }
  end

  def update(data)
    return @message = I18n.t(:necessary_select_delivery) unless data[:price]

    delivery = Delivery.find_by_price(data[:price])
    order = Order.find(@order_id)
    order.check_payment! if order&.checking_delivery?
    order.update(delivery_id: delivery.id)
  end

  def check_addresses(order)
    return @message = I18n.t(:fields_tables_must_be_fill_in) unless BillingAddress.exists?(addressed: order)

    billing_address = BillingAddress.where(addressed_id: @order_id, addressed_type: 'Order').first
    shipping_address = ShippingAddress.where(addressed_id: @order_id, addressed_type: 'Order').first
    @message = I18n.t(:fields_tables_must_be_fill_in) if billing_address.is_one_table.zero? && shipping_address.nil?
  end
end
