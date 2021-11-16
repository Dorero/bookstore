# frozen_string_literal: true

class SortBooksQuery
  NEW = 'Newest first'
  PRICE_HIGHT = 'Price: hight to low'
  PRICE_LOW = 'Price: low to hight'
  TITLE_ASC = 'Title: A - Z'
  TITLE_DESC = 'Title: Z - A'

  OPTIONS = { NEW => %i[created_at desc], PRICE_HIGHT => %i[price desc], PRICE_LOW => %i[price asc],
              TITLE_ASC => %i[name asc], TITLE_DESC => %i[name desc] }.freeze

  def initialize(type_sort, relation = Book.all)
    @type_sort = type_sort || NEW
    @relation = relation
  end

  def call
    return order(*OPTIONS[@type_sort]) if OPTIONS.include?(@type_sort)

    order(:name, :asc)
  end

  private

  def order(field, direction)
    @relation.includes(:authors).order("#{field} #{direction}")
  end
end
