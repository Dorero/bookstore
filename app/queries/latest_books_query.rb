# frozen_string_literal: true

class LatestBooksQuery
  def initialize(quantity, relation = Book.all)
    @relation = relation
    @quantity = quantity
  end

  def call
    @relation.includes(:authors).group(%i[id name]).order(created_at: :desc).limit(@quantity)
  end
end
