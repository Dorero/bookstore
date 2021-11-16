# frozen_string_literal: true

class BooksByCategoryQuery
  def initialize(category_id = nil, relation = Book.all)
    @category_id = category_id
    @relation = relation
  end

  def call
    return collection unless @category_id

    collection.where(category_id: @category_id)
  end

  private

  def collection
    @collection ||= @relation.includes(:authors)
  end
end
