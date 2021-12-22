# frozen_string_literal: true

class SortBooksQuery
  NEW = :newest_first
  PRICE_HIGHT = :price_hight
  PRICE_LOW = :price_low
  TITLE_ASC = :title_asc
  TITLE_DESC = :title_desc

  OPTIONS = { NEW => %i[created_at desc], PRICE_HIGHT => %i[price desc], PRICE_LOW => %i[price asc],
              TITLE_ASC => %i[name asc], TITLE_DESC => %i[name desc] }.freeze

  def initialize(type_sort, relation = Book.all)
    @type_sort = (type_sort || NEW).to_sym
    @relation = relation
  end

  def call
    return popular if @type_sort == :popular_first
    return order(*OPTIONS[@type_sort]) if OPTIONS.include?(@type_sort)

    order(:name, :asc)
  end

  private

  def order(field, direction)
    @relation.includes(:authors).order("#{field} #{direction}")
  end

  def popular
    @relation.includes(:authors).where(id: SavedBook.select('book_id, COUNT(book_id) as count')
                                                    .group(:book_id).order(count: :desc).pluck(:book_id))
  end
end
