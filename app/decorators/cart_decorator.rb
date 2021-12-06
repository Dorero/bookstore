# frozen_string_literal: true

class CartDecorator < Draper::Decorator
  delegate_all

  def price
    object.books.reduce(0) { |sum, book| sum + book.price }
  end

  def price_with_discount
    object.decorate.price - object.decorate.discount
  end

  def discount
    object.coupon&.pre_use? ? object.coupon.discount : 0
  end
end
