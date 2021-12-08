# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all

  def total_price
    SavedBook.where(order_id: object.id).sum(:total_price)
  end

  def price_with_discount
    object.decorate.total_price - object.decorate.discount
  end

  def discount
    object.coupon&.pre_use? ? object.coupon.discount : 0.00
  end
end
