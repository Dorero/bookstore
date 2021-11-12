# frozen_string_literal: true

class HomePageController < ApplicationController
  def show
    @books = LatestBooksQuery.new(3).call
  end
end
