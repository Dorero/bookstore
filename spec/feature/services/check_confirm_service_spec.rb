# frozen_string_literal: true

RSpec.describe 'CheckConfirm', type: :feature, js: true do
  let!(:order_with_book) do
    create(:saved_book, :book_with_image, order: create(:order, :with_all_tables,
                                                        status: 'checking_confirm'))
  end
  let!(:payment) { create(:payment, order: order_with_book.order) }
  let!(:user) { create(:user) }

  before do
    page.set_rack_session(quantity_books: 2, current_cart: order_with_book.order.id)
    user.confirm
    sign_in user
    visit checking_path
  end

  describe '#show' do
    it { expect(page).to have_content(I18n.t(:billing_address)) }
    it { expect(page).to have_content(I18n.t(:shipping_address)) }
    it { expect(page).to have_content(I18n.t(:shipmets)) }
    it { expect(page).to have_content(I18n.t(:payment_info)) }
    it { expect(page).to have_content(payment.decorate.number_card) }
    it { expect(page).to have_current_path(checking_path) }
  end

  describe '#update' do
    before { click_link(I18n.t(:place_order)) }

    it { expect(page).to have_content(I18n.t(:thank_for_order)) }
    it { expect(page).to have_current_path(checking_path) }
  end
end
