# frozen_string_literal: true

class HomePageController < ApplicationController
  def index
    books = LatestBooksQuery.new(3).call
    render(template: 'home_page/index', locals: { books: books })
  end
end
