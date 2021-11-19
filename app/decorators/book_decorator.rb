# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  delegate_all

  def materials
    object.materials.sub(' ', ', ')
  end

  def dimensions
    "#{I18n.t(:hegiht)}: #{object.height} x #{I18n.t(:width)}: #{object.width} x #{I18n.t(:depth)}: #{object.depth}"
  end
end
