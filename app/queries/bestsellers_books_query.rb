# frozen_string_literal: true

class BestsellersBooksQuery
  FIRST_BESTSELLERS_BOOKS = 4
  ORDERED_BOOKS = %i[complete in_delivery delivered canceled].freeze

  def initialize(relation = Book.all)
    @relation = relation
  end

  def call
    @relation.includes(:authors).where(id: SavedBook.select('book_id, COUNT(book_id) as count')
                                 .group(:book_id).order(count: :desc).pluck(:book_id)).joins(:orders)
             .where(orders: { status: ORDERED_BOOKS }).limit(FIRST_BESTSELLERS_BOOKS)
  end
end
