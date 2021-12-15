# frozen_string_literal: true

RSpec.describe 'Admin', type: :request do
  let!(:admin) { create(:admin_user) }
  let!(:review) { create(:review) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    before { get admin_reviews_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #view' do
    before { get admin_review_path(review.id) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'PATCH #approved' do
    before { patch approve_admin_review_path(review.id) }

    it { expect(response).to redirect_to(admin_reviews_path) }
  end

  describe 'PATCH #rejected' do
    before { patch reject_admin_review_path(review.id) }

    it { expect(response).to redirect_to(admin_reviews_path) }
  end
end
