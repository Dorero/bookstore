# frozen_string_literal: true

RSpec.describe 'CheckAddress', type: :feature, js: true do
  let!(:order_with_book) { create(:saved_book, :book_with_image, order: create(:order, status: 'checking_address')) }
  let!(:user) { create(:user) }

  before do
    page.set_rack_session(quantity_books: 2, current_cart: order_with_book.order.id)
    user.confirm
    sign_in user
    visit checking_path
  end

  describe '#show' do
    it { expect(page).to have_current_path(checking_path) }
  end

  describe '#update' do
    context 'when success' do
      let(:address_data) { attributes_for(:address) }
      let(:country) { 'Germany' }

      before do
        fill_in('address[billing_address][first_name]', with: address_data[:first_name])
        fill_in('address[billing_address][last_name]', with: address_data[:last_name])
        fill_in('address[billing_address][address]', with: address_data[:address])
        fill_in('address[billing_address][city]', with: address_data[:city])
        select country, from: 'address[billing_address][country]'
        fill_in('address[billing_address][zip]', with: address_data[:zip])
        fill_in('address[billing_address][phone]', with: address_data[:phone])

        fill_in('address[shipping_address][first_name]', with: address_data[:first_name])
        fill_in('address[shipping_address][last_name]', with: address_data[:last_name])
        fill_in('address[shipping_address][address]', with: address_data[:address])
        fill_in('address[shipping_address][city]', with: address_data[:city])
        select country, from: 'address[shipping_address][country]'
        fill_in('address[shipping_address][zip]', with: address_data[:zip])
        fill_in('address[shipping_address][phone]', with: address_data[:phone])
        click_button(I18n.t(:continue))
      end

      it { expect(page).to have_content(I18n.t(:addresses_saved)) }
      it { expect(page).to have_current_path(checking_path) }
    end

    context 'when failed' do
      let(:address_data) { attributes_for(:address, phone: 'qweqr') }
      let(:country) { 'Germany' }

      before do
        fill_in('address[billing_address][first_name]', with: address_data[:first_name])
        fill_in('address[billing_address][last_name]', with: address_data[:last_name])
        fill_in('address[billing_address][address]', with: address_data[:address])
        fill_in('address[billing_address][city]', with: address_data[:city])
        select country, from: 'address[billing_address][country]'
        fill_in('address[billing_address][zip]', with: address_data[:zip])
        fill_in('address[billing_address][phone]', with: address_data[:phone])

        fill_in('address[shipping_address][first_name]', with: address_data[:first_name])
        fill_in('address[shipping_address][last_name]', with: address_data[:last_name])
        fill_in('address[shipping_address][address]', with: address_data[:address])
        fill_in('address[shipping_address][city]', with: address_data[:city])
        select country, from: 'address[shipping_address][country]'
        fill_in('address[shipping_address][zip]', with: address_data[:zip])
        fill_in('address[shipping_address][phone]', with: address_data[:phone])
        click_button(I18n.t(:continue))
      end

      it { expect(page).to have_content(I18n.t(:phone_not_by_country)) }
      it { expect(page).to have_current_path(checking_path) }
    end
  end
end
