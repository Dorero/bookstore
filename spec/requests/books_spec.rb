# frozen_string_literal: true

RSpec.describe 'Books', type: :request do
  describe 'GET #index' do
    before { get books_path }

    it 'returns http success index books' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let!(:book) { create(:book) }

    before { get book_path(book.id) }

    it 'returns http success show book' do
      expect(response).to have_http_status(:success)
    end
  end
end
