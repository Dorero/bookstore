# frozen_string_literal: true

RSpec.describe 'CheckLogins', type: :feature, js: true do
  let!(:cart_with_book) { create(:saved_book) }
  let!(:user) { create(:user) }

  let(:user_data) { attributes_for(:user) }

  before do
    user.confirm
    page.set_rack_session(quantity_books: 2, current_cart: cart_with_book.order.id)
    visit(check_login_path)
  end

  describe '#check' do
    it { expect(page).to have_current_path(check_login_path) }
  end

  describe '#login' do
    context 'login user with correct password' do
      before do
        fill_in('user_email_login', with: user.email)
        fill_in('user[password]', with: user.password)
        click_button(I18n.t(:login_with_password))
      end

      it { expect(page).to have_content(I18n.t(:'devise.sessions.signed_in')) }
      it { expect(page).to have_current_path(checking_path) }
    end

    context 'login user with wrong password' do
      before do
        fill_in('user_email_login', with: user.email)
        fill_in('user[password]', with: 'wrong_password_223')
        click_button(I18n.t(:login_with_password))
      end

      it { expect(page).to have_content(I18n.t(:'devise.failure.invalid', authentication_keys: 'email')) }
      it { expect(page).to have_current_path(check_login_path) }
    end
  end

  describe '#quick_register' do
    context 'register with exist user' do
      before do
        fill_in('user_email_register', with: user.email)
        click_button(I18n.t(:continue_to_checkout))
      end

      it { expect(page).to have_content(I18n.t(:account_exist)) }
      it { expect(page).to have_current_path(check_login_path) }
    end

    context 'register new user' do
      before do
        fill_in('user_email_register', with: user_data[:email])
        click_button(I18n.t(:continue_to_checkout))
      end

      it { expect(page).to have_content(I18n.t(:'devise.sessions.signed_in')) }
      it { expect(page).to have_current_path(checking_path) }
    end
  end
end
