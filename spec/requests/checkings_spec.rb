# frozen_string_literal: true

RSpec.describe 'Checkings', type: :request do
  describe 'GET #check_address' do
    before { get checking_path }

    it { expect(response).to have_http_status(:success) }
  end
end
