# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def image_letter
    object.email.first.capitalize
  end

  def show_email_or_name
    (object.decorate.name.length > 1 ? object.decorate.name : object.email).to_s
  end
end
