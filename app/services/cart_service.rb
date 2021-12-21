# frozen_string_literal: true

class CartService
  def initialize(book_id, quantity_books, cart_id = nil)
    @cart_id = cart_id
    @book_id = book_id
    @quantity_books = quantity_books.to_i
  end

  def create_or_update
    cart = Order.find_by(id: @cart_id)
    cart = Order.create unless cart&.cart?
    @cart_id = cart.id
    book = SavedBook.find_by(book_id: @book_id)
    book&.open? ? (@quantity_books += book.quantity) && update : create
    cart
  end

  def create
    SavedBook.create(book_id: @book_id, order_id: @cart_id, quantity: @quantity_books, price: Book.find(@book_id).price)
  end

  def update_by_one(direction)
    @quantity_books += direction.to_i
    return if @quantity_books.zero?

    update
  end

  def update
    SavedBook.find_by(book_id: @book_id).update(quantity: @quantity_books, price: Book.find(@book_id).price,
                                                status: :pre_order)
  end

  def add_user(user_id)
    Order.find(@cart_id).update(user_id: user_id)
  end

  def select
    cart = Order.find(@cart_id)
    { quantity_books: @quantity_books, sub_total_price: Book.find(@book_id).price * @quantity_books,
      sub_total_order_price: cart.decorate.sub_total_price, discount: cart.decorate.discount,
      order_total_price: cart.decorate.order_total_price }
  end
end
