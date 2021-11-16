# frozen_string_literal: true

class BooksByCategoryQuery
  def initialize(category_id = nil, relation = Book.all)
    @category_id = category_id
    @relation = relation
  end

  def call
    return @relation.includes(:authors) unless @category_id

    @relation.includes(:authors).where(category_id: @category_id)
  end
end
