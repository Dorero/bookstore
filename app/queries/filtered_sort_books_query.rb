# frozen_string_literal: true

class FilteredSortBooksQuery
  def initialize(category_id = nil, type_sort = nil, relation = Book.all)
    @category_id = category_id
    @type_sort = type_sort
    @relation = relation
  end

  def call
    filtered_books = BooksByCategoryQuery.new(@category_id).call
    SortBooksQuery.new(@type_sort, filtered_books).call
  end
end
