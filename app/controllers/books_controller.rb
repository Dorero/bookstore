# frozen_string_literal: true

class BooksController < ApplicationController
  MAX_SIZE_DESCRIPTION = 250

  before_action :permit_params

  def index
    @page = 1
    Paginator.instance_variable_set(:@page, @page)
    @total_quantity = Book.all.count
    @categories = Category.all.includes(:books)
    @books = Paginator.computing(FilteredSortBooksQuery.new(params[:category], params[:sort]).call)
  end

  def show
    @book = Book.all.includes(:authors).find_by(id: params[:id]).decorate
    redirect_to controller: :error, action: :not_found unless @book
  end

  def load
    render json: Paginator.computing(
      FilteredSortBooksQuery.new(
        params[:category].empty? ? nil : params[:category], params[:sort]
      ).call.joins(:authors),
      params[:page].to_i
    ).to_json
  end

  private

  def permit_params
    params.permit(:sort, :sort_name, :category, :id, :page)
  end
end
