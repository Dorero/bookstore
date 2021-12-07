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

  describe 'POST #create' do
    let(:book_data) { attributes_for(:book) }
    let(:image) { create(:image)[:image] }

    before do
      post admin_books_path, params: { book: { name: book_data[:name], description: book_data[:description],
                                               price: book_data[:price], year: book_data[:year],
                                               height: book_data[:height], width: book_data[:width],
                                               depth: book_data[:depth], materials: book_data[:materials],
                                               images_attributes: image } }
    end

    it { expect(response).to have_http_status(:success) }
  end
end
