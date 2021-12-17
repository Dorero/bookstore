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

  describe 'GET #edit' do
    before { get edit_admin_order_path(order.id) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'PATCH #update' do
    context 'success change state' do
      before { patch admin_order_path(order.id), params: { order: { status: 'canceled' }, id: order.id } }

      it { expect(response).to redirect_to(admin_orders_path) }
    end

    context 'failed change state' do
      context 'available statuses' do
        before do
          order.canceled!
          patch admin_order_path(order.id), params: { order: { status: 'delivered' }, id: order.id }
        end

        it { expect(response).to redirect_to(edit_admin_order_path(order.id)) }
      end

      context 'unexpected statuses' do
        before do
          order.in_delivery!
          patch admin_order_path(order.id), params: { order: { status: 'given away for free' }, id: order.id }
        end

        it { expect(response).to redirect_to(edit_admin_order_path(order.id)) }
      end
    end
  end
end
