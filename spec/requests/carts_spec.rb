# frozen_string_literal: true

RSpec.describe 'Carts', type: :request do
  let!(:cart_with_book) { create(:saved_book) }
  let!(:image) { create(:image, book: cart_with_book.book) }

  context 'with create cart and add book' do
    before { post cart_path, params: { book_id: cart_with_book.book.id } }

    describe 'GET #show' do
      before do
        get cart_path
      end

      it { expect(response).to have_http_status(:success) }
    end

    describe 'POST #delete_book' do
      before { post delete_book_cart_path, params: { book_id: cart_with_book.book.id } }

      it { expect(response).to redirect_to(empty_cart_path) }
    end

    describe 'POST #check_coupon' do
      let!(:coupon) { create(:coupon) }

      before { post check_coupon_cart_path, params: { coupon: coupon.number } }

      it { expect(response).to redirect_to(cart_path) }
    end

    describe 'POST #update_prices' do
      before { post update_prices_cart_path, params: { quantity_books: 3, book_id: cart_with_book.book.id } }

      it { expect(response.content_type).to eq('application/json; charset=utf-8') }
    end

    describe 'POST #increment_quantity_books' do
      before { post increment_quantity_books_cart_path, params: { quantity_books: 3, book_id: cart_with_book.book.id } }

      it { expect(response).to redirect_to(cart_path) }
    end

    describe 'POST #decrement_quantity_books' do
      before { post decrement_quantity_books_cart_path, params: { quantity_books: 3, book_id: cart_with_book.book.id } }

      it { expect(response).to redirect_to(cart_path) }
    end
  end

  context 'without create cart' do
    describe 'GET #empty' do
      before { get empty_cart_path }

      it { expect(response).to have_http_status(:success) }
    end

    describe 'POST #create' do
      before { post cart_path, params: { book_id: cart_with_book.book.id } }

      it { expect(response).to redirect_to(book_path(cart_with_book.book.id)) }
    end
  end
end
