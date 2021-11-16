# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    params.permit(:sort, :category)
    filtered_books = BooksByCategoryQuery.new(params[:category]).call
    sorted_books = SortBooksQuery.new(params[:sort], filtered_books).call
    @pagy, @books = pagy(sorted_books)
    @total_quantity = Book.all.count
    @categories = Category.all.includes(:books)
  end

  def show
    params.permit(:id)
    @book = Book.includes(:authors).find_by(id: params[:id])
    redirect_to('/404') unless @book
  end
end
