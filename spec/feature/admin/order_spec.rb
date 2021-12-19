# frozen_string_literal: true

RSpec.describe 'Admin/Order', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:order) { create(:order, status: 'delivered') }

  before { sign_in admin }

  describe '#index' do
    before { visit admin_orders_path }

    it { expect(page).to have_current_path(admin_orders_path) }
  end

  describe '#show' do
    before { visit admin_order_path(order.id) }

    it { expect(page).to have_current_path(admin_order_path(order.id)) }
  end

  describe '#batch_action_admin_orders' do
    before do
      visit admin_orders_path
      find(:css, "#batch_action_item_#{order.id}").set(true)
      click_link('Batch Actions')
      click_link('Change State Selected')
    end

    context 'when success change status' do
      before do
        select 'canceled', from: 'type'
        click_button('OK')
      end

      it { expect(page).to have_content(I18n.t(:order_status_success_changed)) }
      it { expect(page).to have_current_path(admin_orders_path) }
    end

    context 'when failed change status' do
      before do
        select 'delivered', from: 'type'
        click_button('OK')
      end

      it { expect(page).to have_content(I18n.t(:cannot_set_delivered)) }
      it { expect(page).to have_current_path(admin_orders_path) }
    end
  end
end
