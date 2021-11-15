# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    all_books = Book.all
    @total_quantity = all_books.count
    @books = AllBooksQuery.new(12, all_books).call
    @categories = Category.all.includes(:books)
  end

  def show
    @book = Book.includes(:authors).find_by(id: params[:id])
  end

  def category
    @total_quantity = Book.all.count
    category_books = BooksByCategoryQuery.new(params[:id]).call
    @books = AllBooksQuery.new(12, category_books).call
    @categories = Category.all.includes(:books)
    render('books/index')
  end
end
