# frozen_string_literal: true

class CartsController < ApplicationController
  def create
    set_cart
    redirect_to book_path(params[:book_id]), alert: I18n.t(:book_add_to_cart)
  end

  def show
    return redirect_to empty_cart_path unless session[:quantity_books]

    @cart = Order.where(id: session[:current_cart]).first
    @books = @cart.books
  end

  def empty; end

  def delete_book
    SavedBook.where(book_id: params[:book_id]).destroy_all
    session[:quantity_books] = nil if Order.find(session[:current_cart]).books.empty?
    redirect_to empty_cart_path, alert: I18n.t(:book_success_delete)
  end

  def check_coupon
    redirect_to cart_path, alert: CouponService.new(params[:coupon], session[:current_cart]).permit_coupon
  end

  def increment_quantity_books
    CartService.new(params[:book_id], params[:quantity_books]).update_by_one(:plus)
    redirect_to cart_path
  end

  def decrement_quantity_books
    CartService.new(params[:book_id], params[:quantity_books]).update_by_one(:minus)
    redirect_to cart_path
  end

  def update_prices
    render json: CartService.new(params[:book_id], params[:quantity_books], session[:current_cart]).select
  end

  private

  def set_cart
    cart = CartService.new(params[:book_id], params[:quantity_books], session[:current_cart]).create
    session[:current_cart] = cart.id
    session[:quantity_books] = cart.books.count
  end
end
