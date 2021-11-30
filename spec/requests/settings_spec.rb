# frozen_string_literal: true

RSpec.describe 'Settings', type: :request do
  describe 'GET #edit' do
    let!(:user) { create(:user, password: '123QWEasd') }

    context 'login existing user' do
      before do
        user.confirm
        sign_in user
        get edit_setting_path
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'attempt to login without authentication' do
      before { get edit_setting_path }

      it { expect(response).to have_http_status(:found) }
    end
  end
end
