# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  delegate_all

  def materials
    object.materials.sub(' ', ', ')
  end

  def dimensions
    "H: #{object.height} x W: #{object.width} x D: #{object.depth}"
  end
end
