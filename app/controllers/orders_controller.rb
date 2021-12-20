# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = FilteredOrdersQuery.new(params[:filter], current_user).call
  end

  def show
    @order = Order.find(params[:id])
  end
end
