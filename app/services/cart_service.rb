# frozen_string_literal: true

class CartService
  DECREMENT = :minus
  SHIFT = 1

  def initialize(book_id, quantity_books, cart_id = nil)
    @cart_id = cart_id
    @book_id = book_id
    @quantity_books = quantity_books.to_i
  end

  def create
    cart = Order.find_or_create_by(id: @cart_id)
    SavedBook.find_or_initialize_by(book_id: @book_id).update!(order: cart, quantity_books: @quantity_books,
                                                               total_price: Book.find(@book_id).price * @quantity_books)
    cart
  end

  def update_by_one(operation)
    @quantity_books = operation == DECREMENT ? @quantity_books - SHIFT : @quantity_books + SHIFT
    return if @quantity_books.zero?

    update
  end

  def update
    SavedBook.find_by(book_id: @book_id).update!(quantity_books: @quantity_books,
                                                 total_price: Book.find(@book_id).price * @quantity_books)
  end

  def select
    cart = Order.find(@cart_id)
    sub_total_price = Book.find(@book_id).price * @quantity_books
    SavedBook.find_by(book_id: @book_id).update!(quantity_books: @quantity_books, total_price: sub_total_price)
    { quantity_books: @quantity_books, sub_total_price: sub_total_price,
      sub_total_order_price: cart.decorate.total_price, discount: cart.decorate.discount,
      order_total_price: cart.decorate.price_with_discount }
  end
end
