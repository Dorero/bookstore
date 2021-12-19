# frozen_string_literal: true

RSpec.describe 'CheckCompleteService', type: :feature, js: true do
  let!(:order_with_book) do
    create(:saved_book, :book_with_image, order: create(:order, :with_all_tables,
                                                        status: 'checking_complete'))
  end
  let!(:user) { create(:user) }

  before do
    page.set_rack_session(quantity_books: 2, current_cart: order_with_book.order.id)
    user.confirm
    sign_in user
    visit checking_path
  end

  describe '#show' do
    before { click_link(I18n.t(:back_to_store)) }

    it { expect(page).to have_content(I18n.t(:thank_for_order)) }
    it { expect(page).to have_current_path(books_path) }
  end
end
