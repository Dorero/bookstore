# frozen_string_literal: true

class PaymentDecorator < Draper::Decorator
  delegate_all

  def number_card
    "** ** ** #{object.number.to_s.last(4)}"
  end
end
