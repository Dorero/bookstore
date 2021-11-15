# frozen_string_literal: true

class BooksByCategoryQuery
  def initialize(category_id, relation = Book.all)
    @category_id = category_id
    @relation = relation
  end

  def call
    @relation.where(category_id: @category_id)
  end
end
