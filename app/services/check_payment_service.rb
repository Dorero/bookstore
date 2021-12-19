# frozen_string_literal: true

class CheckPaymentService
  attr_reader :message

  CheckPayment = Struct.new(:order, :payment)

  def initialize(user_id, order_id)
    @user_id = user_id
    @order_id = order_id
    @order = Order.find(@order_id)
    @payment = Payment.find_or_initialize_by(order_id: order_id)
  end

  def show
    CheckPayment.new(@order, PaymentForm.new(@payment))
  end

  def update(data)
    payment_form = PaymentForm.new(@payment)
    unless payment_form.validate(data[:payment])
      @message = I18n.t(:invalid_data)
      return false
    end

    @order.check_confirm! if @order.checking_payment?
    payment_form.save
  end
end
