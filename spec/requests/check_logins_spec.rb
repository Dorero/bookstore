# frozen_string_literal: true

RSpec.describe 'CheckLogins', type: :request do
  let!(:cart_with_book) { create(:saved_book) }
  let!(:user) { create(:user) }

  before do
    user.confirm
    post cart_path, params: { book_id: cart_with_book.book.id }
  end

  describe 'GET #check' do
    before { get check_login_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST #login' do
    context 'login user with correct password' do
      before { post login_check_login_path, params: { user: { email: user.email, password: user.password } } }

      it { expect(response).to redirect_to(check_address_checking_path) }
    end

    context 'login user with wrong password' do
      before { post login_check_login_path, params: { user: { email: user.email, password: 'wrong password223' } } }

      it { expect(response).to redirect_to(check_login_path) }
    end
  end

  describe 'POST #quick_register' do
    context 'with exist user' do
      before { post quick_register_check_login_path, params: { user: { email: user.email } } }

      it { expect(response).to redirect_to(check_login_path) }
    end

    context 'without exist user' do
      let(:user_data) { attributes_for(:user) }

      before { post quick_register_check_login_path, params: { user: { email: user_data[:email] } } }

      it { expect(response).to redirect_to(check_address_checking_path) }
    end
  end
end
