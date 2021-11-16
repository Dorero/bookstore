# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    it 'returns http success' do
      get books_path
      expect(response).to have_http_status(:success)
    end
  end
end
