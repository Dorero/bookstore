# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    form = ReviewForm.new(Review.new)
    review = params[:review]

    return redirect_to(book_path(review[:book_id]), errors: form.errors) unless form.validate(review)

    form.save
    redirect_to(book_path(review[:book_id]), alert: I18n.t(:thanks_for_review))
  end
end
