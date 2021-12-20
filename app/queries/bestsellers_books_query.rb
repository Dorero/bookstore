# frozen_string_literal: true

class BestsellersBooksQuery
  def initialize(relation = Book.all)
    @relation = relation
  end

  def call
    bestsellers_by_category(
      @relation.where(id: SavedBook.where(status: :closed).select('book_id, COUNT(book_id) as count')
                                                         .group(:book_id).order(count: :desc).pluck(:book_id))
    )
  end

  private

  def bestsellers_by_category(books)
    books_by_category = Category.select(:id, :name).each_with_object({}) do |category, struct|
      struct[category.name.tr(' ', '_').downcase.to_sym] = books.where(category: category).first
    end.values.unshift(books.first).compact

    Book.includes(:authors).where(id: books_by_category)
  end
end
