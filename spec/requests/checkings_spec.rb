# frozen_string_literal: true

RSpec.describe 'Checkings', type: :request do
  let!(:cart_with_book) { create(:saved_book) }

  describe 'GET #show' do
    context 'when quick register' do
      let(:user_data) { attributes_for(:user) }

      before do
        post cart_path, params: { book_id: cart_with_book.book.id }
        post quick_register_check_login_path, params: { user: { email: user_data[:email] } }
        get checking_path
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when login' do
      let!(:user) { create(:user, password: '123QWEasd') }

      before do
        user.confirm
        post cart_path, params: { book_id: cart_with_book.book.id }
        post login_check_login_path, params: { user: { email: user.email, password: user.password } }
      end

      it { expect(response).to redirect_to(checking_path) }
    end

    context 'without authentication' do
      before do
        post cart_path, params: { book_id: cart_with_book.book.id }
        get checking_path
      end

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end
end
