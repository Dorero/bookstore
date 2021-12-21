# frozen_string_literal: true

RSpec.describe 'Admin/Order', type: :request do
  let!(:admin) { create(:admin_user) }
  let!(:order) { create(:order) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    before { get admin_orders_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get admin_order_path(order.id) }

    it { expect(response).to have_http_status(:success) }
  end
end
