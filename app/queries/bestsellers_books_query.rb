# frozen_string_literal: true

class BestsellersBooksQuery
  def initialize(relation = Book.all)
    @relation = relation
  end

  def call
    @relation.includes(:authors).where(id: SavedBook.select('book_id, COUNT(book_id) as count')
                                 .group(:book_id).order(count: :desc).limit(4).select(:book_id))
  end
end
