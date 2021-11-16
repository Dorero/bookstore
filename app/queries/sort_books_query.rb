# frozen_string_literal: true

class SortBooksQuery
  def initialize(type_sort, relation = Book.all)
    @type_sort = type_sort || 'new'
    @relation = relation
  end

  def call
    return order(:created_at, :desc) if @type_sort == 'new'
    return order(:price, :desc) if @type_sort == 'price-hight'
    return order(:price, :asc) if @type_sort == 'price-low'
    return order(:name, :asc) if @type_sort == 'title-asc'

    order(:name, :desc)
  end

  private

  def order(field, direction)
    @relation.includes(:authors).order("#{field} #{direction}")
  end

  def popular
    UserBook.all.group(:book_id)
  end
end
