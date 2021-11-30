# frozen_string_literal: true

RSpec.describe 'User', type: :request do
  describe 'GET #new' do
    context 'login existing user' do
      before { get new_user_session_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'registration new user' do
      before { get new_user_registration_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'set new password' do
      before { get new_user_password_path }

      it { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #edit' do
    context 'edit password without email links should be redirect' do
      before { get edit_user_password_path }

      it { expect(response).to have_http_status(:found) }
    end
  end

  describe 'POST #passthru' do
    context 'auth through facebook should be redirect in facebook page' do
      before { post user_facebook_omniauth_authorize_path }

      it { expect(response).to have_http_status(:found) }
    end
  end
end
