# frozen_string_literal: true

class AuthorDecorator < Draper::Decorator
  delegate_all

  def name
    "#{object.first_name} #{object.last_name}"
  end
end
