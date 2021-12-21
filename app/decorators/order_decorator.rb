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

  def title
    "#{I18n.t(:order)} #{object.number}"
  end

  def status
    status = object.status
    if %w[checking_address checking_delivery checking_payment checking_confirm checking_complete].include?(status)
      status = 'in_progress'
    end
    status = I18n.t(:waiting_process) if status == 'complete'

    return status.capitalize if status.split('_').is_a?(String)

    status.split('_').map(&:capitalize).join(' ')
  end
end
