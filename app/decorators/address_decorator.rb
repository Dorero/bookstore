# frozen_string_literal: true

class AddressDecorator < Draper::Decorator
  delegate_all

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def city_zip
    "#{object.city} #{object.zip}"
  end
end
