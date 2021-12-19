# frozen_string_literal: true

RSpec.describe 'Checkings', type: :feature, js: true do
  describe '#show' do
    let!(:order_with_book) { create(:saved_book, :book_with_image) }
    let!(:user) { create(:user, password: '123QWEasd') }

    let(:user_data) { attributes_for(:user) }

    before { page.set_rack_session(quantity_books: 2, current_cart: order_with_book.order.id) }

    context 'when quick register' do
      before do
        visit check_login_path
        fill_in('user_email_register', with: user_data[:email])
        click_button(I18n.t(:continue_to_checkout))
      end

      it { expect(page).to have_current_path(checking_path) }
    end

    context 'when login' do
      before do
        user.confirm
        visit check_login_path
        fill_in('user_email_login', with: user.email)
        fill_in('user[password]', with: user.password)
        click_button(I18n.t(:login_with_password))
        visit checking_path
      end

      it { expect(page).to have_current_path(checking_path) }
    end

    context 'without authentication' do
      before { visit checking_path }

      it { expect(page).to have_current_path(new_user_session_path) }
    end
  end
end
