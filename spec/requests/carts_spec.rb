# frozen_string_literal: true

RSpec.describe 'Carts', type: :request do
  let!(:cart_with_book) { create(:sale_book) }

  describe 'GET #show' do
    before { get cart_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST #create' do
    before { post cart_path, params: { book_id: cart_with_book.book.id } }

    it { expect(response).to redirect_to(book_path(cart_with_book.book.id)) }
  end

  describe 'POST #delete_book' do
    before { post delete_book_cart_path, params: { book_id: cart_with_book.book.id } }

    it { expect(response).to redirect_to(cart_path) }
  end

  describe 'POST #check_coupon' do
    let!(:coupon) { create(:coupon) }

    before { post check_coupon_cart_path, params: { coupon: coupon.number } }

    it { expect(response).to redirect_to(cart_path) }
  end
end
