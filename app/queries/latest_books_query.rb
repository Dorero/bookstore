# frozen_string_literal: true

class LatestBooksQuery
  def initialize(quantity, relation = Book)
    @relation = relation
    @quantity = quantity
  end

  def call
    @relation.group(%i[id name]).order(id: :desc).limit(@quantity).includes([:authors])
  end
end
