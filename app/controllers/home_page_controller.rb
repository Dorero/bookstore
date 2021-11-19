# frozen_string_literal: true

class HomePageController < ApplicationController
  LIMIT_LATEST_BOOK = 3

  def show
    @books = LatestBooksQuery.new(LIMIT_LATEST_BOOK).call
  end
end
