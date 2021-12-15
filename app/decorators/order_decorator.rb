# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all

  def total_price
    SavedBook.where(order_id: object.id).sum { |book| book.price.to_f * book.quantity.to_f }
  end

  def price_with_discount
    object.decorate.total_price - object.decorate.discount
  end

  def discount
    object.coupon&.discount.to_f
  end
end
