# frozen_string_literal: true

class Paginator
  LIMIT = 12
  @page = 1

  def self.computing(relation, page = @page)
    relation.limit(LIMIT).offset(offset(page))
  end

  def self.offset(page)
    amount = (@page - 1) * LIMIT
    @page += page
    amount
  end
end
