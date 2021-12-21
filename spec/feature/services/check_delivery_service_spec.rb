# frozen_string_literal: true

RSpec.describe 'CheckDelivery', type: :feature, js: true do
  let!(:order_with_book) { create(:saved_book, :book_with_image, order: create(:order, status: 'checking_delivery')) }
  let!(:delivery) { create(:delivery) }
  let!(:user) { create(:user) }

  before do
    page.set_rack_session(quantity_books: 2, current_cart: order_with_book.order.id)
    user.confirm
    sign_in user
    visit checking_path
  end

  describe '#show' do
    it { expect(page).to have_current_path(checking_path) }
  end

  describe '#update' do
    before do
      find(".delivery-#{delivery.id}", visible: false).click
      click_button(I18n.t(:continue))
    end

    it { expect(page).to have_current_path(checking_path) }
  end
end
