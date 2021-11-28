# frozen_string_literal: true

class BooksController < ApplicationController
  MAX_SIZE_DESCRIPTION = 250

  before_action :permit_params

  def index
    @total_quantity = Book.all.count
    @categories = Category.all.includes(:books)
    @pagy, @books = pagy(FilteredSortBooksQuery.new(params[:category], params[:sort]).call)
  end

  def show
    @book = Book.all.includes(:authors).find_by(id: params[:id])
    return redirect_to controller: :error, action: :not_found unless @book

    @book = @book.decorate
  end

  private

  def permit_params
    params.permit(:sort, :sort_name, :category, :id, :page)
  end
end
