# frozen_string_literal: true

RSpec.describe 'HomePages', type: :request do
  describe 'GET #show' do
    before { get root_path }

    it { expect(response).to have_http_status(:success) }
  end
end
