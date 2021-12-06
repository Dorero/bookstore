# frozen_string_literal: true

class CartsController < ApplicationController
  def create
    cart = Cart.find_or_create_by(id: session[:current_cart])
    add_books_to_cart(cart)
    session[:current_cart] = cart.id
    session[:quantity_books] = cart.books.count
    redirect_to book_path(params[:book_id]), alert: I18n.t(:book_add_to_cart)
  end

  def show
    @cart = Cart.find_or_initialize_by(id: session[:current_cart])
    @books = @cart.books.distinct
  end

  def delete_book
    SaleBook.where(book_id: params[:book_id]).destroy_all
    redirect_to cart_path, alert: I18n.t(:book_success_delete)
  end

  def check_coupon
    coupon = Coupon.where(number: params[:coupon]).first
    return redirect_to cart_path, alert: coupon&.spent? ? I18n.t(:coupon_spent) : I18n.t(:no_such_coupon) unless coupon

    coupon.pre_use!
    redirect_to cart_path, alert: I18n.t(:coupun_can_be_activated)
  end

  private

  def add_books_to_cart(cart)
    params[:quantity_books].to_i.times { SaleBook.create(sale: cart, book: Book.find(params[:book_id])) }
  end
end
