# frozen_string_literal: true

class BooksController < ApplicationController
  MAX_SIZE_DESCRIPTION = 250
  RATING_STARS_SIZE = 5

  before_action :permit_params

  def index
    @total_quantity = Book.all.count
    @categories = Category.all.includes(:books)
    @pagy, @books = pagy(FilteredSortBooksQuery.new(params[:category], params[:sort]).call)
  end

  def show
    @book = Book.includes(:authors).find_by(id: params[:id])&.decorate
    return redirect_to controller: :error, action: :not_found unless @book

    @reviews = Review.includes(:user).where(book_id: @book.id).where(status: I18n.t(:approved_status))
  end

  private

  def permit_params
    params.permit(:sort, :sort_name, :category, :id, :page)
  end
end
