# frozen_string_literal: true

class DelivaryDecorator < Draper::Decorator
  delegate_all

  def period; end
end
