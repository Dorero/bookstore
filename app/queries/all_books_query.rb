# frozen_string_literal: true

class AllBooksQuery
  def initialize(limit = 12, relation = Book.all)
    @limit = limit
    @relation = relation
  end

  def call
    @relation.includes(:authors).order('name').limit(@limit)
  end
end
