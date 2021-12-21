# frozen_string_literal: true

RSpec.describe 'Admin/Category', type: :request do
  let!(:admin) { create(:admin_user) }
  let!(:category) { create(:category) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    before { get admin_categories_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get admin_category_path(category.id) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #new' do
    before { get new_admin_category_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #edit' do
    before { get edit_admin_category_path(category.id) }

    it { expect(response).to have_http_status(:success) }
  end
end
