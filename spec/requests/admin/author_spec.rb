# frozen_string_literal: true

RSpec.describe 'Admin/Author', type: :request do
  let!(:admin) { create(:admin_user) }
  let!(:author) { create(:author) }

  before { sign_in admin }

  describe 'GET #index' do
    before { get admin_authors_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get admin_author_path(author.id) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #new' do
    before { get new_admin_author_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #edit' do
    before { get edit_admin_author_path(author.id) }

    it { expect(response).to have_http_status(:success) }
  end
end
