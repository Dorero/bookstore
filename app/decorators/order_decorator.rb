# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all

  def sub_total_price
    SavedBook.where(order_id: object.id).sum { |book| book.price.to_f * book.quantity.to_f }
  end

  def order_total_price
    (object.decorate.sub_total_price + object.decorate.shipping) - object.decorate.discount
  end

  def discount
    object.coupon&.discount.to_f
  end

  def shipping
    object.delivery&.price.to_f
  end
end
