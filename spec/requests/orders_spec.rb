# frozen_string_literal: true

RSpec.describe 'Orders', type: :request do
  let!(:order_with_book) { create(:saved_book, :book_with_image, order: create(:order, :with_all_tables)) }
  let!(:payment) { create(:payment, order: order_with_book.order) }
  let!(:user) { create(:user) }

  before do
    user.confirm
    sign_in user
  end

  describe 'GET /index' do
    before { get orders_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before { get order_path(order_with_book.order.id) }

    it { expect(response.body).to include(payment.decorate.number_card) }
    it { expect(response).to have_http_status(:success) }
  end
end
