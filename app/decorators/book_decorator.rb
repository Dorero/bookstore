# frozen_string_literal: true

class BookDecorator < Draper::Decorator
  delegate_all

  def materials
    object.materials.sub(' ', ', ')
  end

  def dimensions
    "#{I18n.t(:hegiht)}: #{object.height} x #{I18n.t(:width)}: #{object.width} x #{I18n.t(:depth)}: #{object.depth}"
  end

  def quantity
    SavedBook.where.not(status: :closed).find_by(book: object).quantity.to_i
  end

  def first_sentence
    object.description.split('.').first
  end

  def price_by_quantity
    book = SavedBook.find_by(book: object)
    book.price * book.quantity
  end
end
