# frozen_string_literal: true

RSpec.describe 'Not Found', type: :request do
  describe 'GET #not_found' do
    before { get '/404' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
