# frozen_string_literal: true

class PaymentDecorator < Draper::Decorator
  delegate_all

  LAST_CARD_NUMBER = 4

  def number_card
    "** ** ** #{object.number.to_s.last(LAST_CARD_NUMBER)}"
  end
end
