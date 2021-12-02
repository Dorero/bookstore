# frozen_string_literal: true

RSpec.describe 'Admin/Book', type: :request do
  let!(:admin) { create(:admin_user) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    before { get admin_books_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get admin_books_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #new' do
    before { get new_admin_book_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #edit' do
    let!(:book) { create(:book) }
    before { get edit_admin_book_path(book.id) }

    it { expect(response).to have_http_status(:success) }
  end
end
