# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    check_permit
    @total_quantity = Book.all.count
    @pagy, @books = pagy_countless(FilteredSortBooksQuery.new(params[:category], params[:sort]).call,
                                   count: @total_quantity, items: 12, cycle: true)
    @categories = Category.all.includes(:books)
  end

  def show
    check_permit
    @book = Book.all.includes(:authors).find_by(id: params[:id])
    redirect_to controller: :error, action: :not_found unless @book
  end

  private

  def check_permit
    params.permit(:sort, :category, :id)
  end
end
