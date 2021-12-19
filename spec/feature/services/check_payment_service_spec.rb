# frozen_string_literal: true

RSpec.describe 'CheckPaymentService', type: :feature, js: true do
  let!(:order_with_book) do
    create(:saved_book, :book_with_image, order: create(:order, :with_all_tables, status: 'checking_payment'))
  end
  let!(:payment) { attributes_for(:payment) }
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
      fill_in('payment[number]', with: payment[:number])
      fill_in('payment[name]', with: payment[:name])
      fill_in('payment[expiration_date]', with: payment[:expiration_date])
      fill_in('payment[cvv]', with: payment[:cvv])
      click_button(I18n.t(:continue))
    end

    it { expect(page).to have_current_path(checking_path) }
  end
end
