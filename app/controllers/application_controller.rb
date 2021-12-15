# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  private

  def prepare_errors(errors)
    errors.each_with_object({}) { |error, memo| memo[error.attribute.to_s] = error.message }
  end

  def after_sign_in_path_for(resource)
    if Order.exists?(user_id: resource.id)
      cart = Order.find_by(user_id: resource.id)
      session[:current_cart] = cart.id
      session[:quantity_books] = cart.books.count
    end
    super
  end
end
