# frozen_string_literal: true

RSpec.describe 'OrdersController', type: :feature, js: true do
  let!(:order_with_book) { create(:saved_book, :book_with_image, order: create(:order, :with_all_tables)) }
  let!(:payment) { create(:payment, order: order_with_book.order) }
  let!(:user) { create(:user) }

  before do
    page.set_rack_session(quantity_books: 2, current_cart: order_with_book.order.id)
    user.confirm
    sign_in user
  end

  describe '#index' do
    before { visit orders_path }

    it { expect(page).to have_current_path(orders_path) }
  end

  describe '#show' do
    before { visit order_path(order_with_book.order.id) }

    it { expect(page).to have_content(payment.decorate.number_card) }
    it { expect(page).to have_current_path(order_path(order_with_book.order.id)) }
  end
end
