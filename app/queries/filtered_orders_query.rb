# frozen_string_literal: true

class FilteredOrdersQuery
  def initialize(filter, user)
    @filter = filter || :complete
    @user = user
  end

  def call
    Order.includes(%i[delivery coupon]).where.not(status: :cart).where(user: @user,
                                                                       status: @filter).order(completed_at: :desc)
  end
end
