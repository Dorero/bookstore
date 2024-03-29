# frozen_string_literal: true

class CouponService
  def initialize(number, cart_id)
    @number = number
    @cart_id = cart_id
  end

  def permit_coupon
    coupon = Coupon.find_by(number: @number)
    return I18n.t(:no_such_coupon) unless coupon
    return I18n.t(:coupon_spent) if coupon.spent?

    cart = Order.find(@cart_id)
    return I18n.t(:coupon_applied) if coupon.pre_use? || cart.coupon_id

    cart.update(coupon_id: coupon.id)
    coupon.pre_use!
    I18n.t(:coupun_can_be_activated)
  end
end
