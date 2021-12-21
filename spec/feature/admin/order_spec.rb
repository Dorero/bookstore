# frozen_string_literal: true

RSpec.describe 'Admin/Order', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:order) { create(:order, status: :complete) }

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
    before { visit admin_orders_path }

    context 'when to in delivery' do
      before do
        click_link(I18n.t(:in_progress_tab))
        find(:css, "#batch_action_item_#{order.id}").set(true)
        click_link('Batch Actions')
        click_link('In Delivery Selected')
      end

      it { expect(page).to have_content(I18n.t(:order_status_success_changed)) }
      it { expect(page).to have_current_path(admin_orders_path) }
    end

    context 'when to delivered' do
      context 'when from in delivery' do
        let!(:order_with_status_in_delivery) { create(:order, status: :in_delivery) }

        before do
          click_link(I18n.t(:in_progress_tab))
          find(:css, "#batch_action_item_#{order_with_status_in_delivery.id}").set(true)
          click_link('Batch Actions')
          click_link('Delivered Selected')
        end

        it { expect(page).to have_content(I18n.t(:order_status_success_changed)) }
        it { expect(page).to have_current_path(admin_orders_path) }
      end

      context 'when from complete' do
        let!(:order_with_status_complete) { create(:order, status: :complete) }

        before do
          click_link(I18n.t(:in_progress_tab))
          find(:css, "#batch_action_item_#{order_with_status_complete.id}").set(true)
          click_link('Batch Actions')
          click_link('Delivered Selected')
        end

        it { expect(page).to have_content(I18n.t(:cannot_set_delivered)) }
        it { expect(page).to have_current_path(admin_orders_path) }
      end
    end

    context 'when to canceled' do
      before do
        click_link(I18n.t(:in_progress_tab))
        find(:css, "#batch_action_item_#{order.id}").set(true)
        click_link('Batch Actions')
        click_link('Canceled Selected')
      end

      it { expect(page).to have_content(I18n.t(:order_status_success_changed)) }
      it { expect(page).to have_current_path(admin_orders_path) }
    end
  end
end
