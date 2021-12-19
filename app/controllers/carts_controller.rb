# frozen_string_literal: true

class CartsController < ApplicationController
  def create
    setup_cart
    flash[:alert] = I18n.t(:book_add_to_cart)
    redirect_back(fallback_location: book_path(params[:book_id]))
  end

  def show
    return unless session[:current_cart]

    @cart = Order.find_by(id: session[:current_cart])
    return session[:current_cart] = nil unless @cart

    @books = @cart.books
  end

  def delete_book
    SavedBook.where(book_id: params[:book_id]).destroy_all
    session[:quantity_books] -= 1
    check_empty_cart
    redirect_to cart_path, alert: I18n.t(:book_success_delete)
  end

  def check_coupon
    redirect_to cart_path, alert: CouponService.new(params[:coupon], session[:current_cart]).permit_coupon
  end

  def update_quantity_books_by_one
    CartService.new(params[:book_id], params[:quantity_books]).update_by_one(params[:direction])
    redirect_to cart_path
  end

  def update_prices
    cart = CartService.new(params[:book_id], params[:quantity_books], session[:current_cart])
    cart.update
    render json: cart.select
  end

  private

  def setup_cart
    cart = CartService.new(params[:book_id], params[:quantity_books], session[:current_cart]).create_or_update
    cart.update(user: current_user) unless cart.user
    setup_session(cart)
  end

  def setup_session(cart)
    session[:current_cart] = cart.id
    session[:quantity_books] = cart.books.count
  end

  def check_empty_cart
    cart = Order.find(session[:current_cart])
    return unless cart.books.empty?

    session[:current_cart] = nil
    session[:quantity_books] = 0
    cart.destroy
  end
end
