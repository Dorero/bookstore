# frozen_string_literal: true

RSpec.describe 'Checkings', type: :feature, js: true do
  let!(:cart_with_book) { create(:saved_book) }
  let!(:image) { create(:image, book: cart_with_book.book) }
  let(:user_data) { attributes_for(:user) }

  before { page.set_rack_session(quantity_books: 2, current_cart: cart_with_book.order.id) }

  describe '#show' do
    context 'through quick register' do
      before do
        page.set_rack_session(quantity_books: 2, current_cart: cart_with_book.order.id)
        visit check_login_path
        fill_in('user_email_register', with: user_data[:email])
        click_button(I18n.t(:continue_to_checkout))
      end

      context 'check address state' do
        let!(:delivery) { create(:delivery) }

        let(:payment) { attributes_for(:payment) }
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

        context 'check delivery state' do
          before do
            find(".delivery-#{delivery.id}", visible: false).click
            click_button(I18n.t(:continue))
          end

          context 'check payment state' do
            before do
              fill_in('payment[number]', with: payment[:number])
              fill_in('payment[name]', with: payment[:name])
              fill_in('payment[expiration_date]', with: payment[:expiration_date])
              fill_in('payment[cvv]', with: payment[:cvv])
              click_button(I18n.t(:continue))
            end

            context 'check confirm state' do
              before { click_link(I18n.t(:place_order)) }

              context 'check complete state' do
                before { click_link(I18n.t(:back_to_store)) }

                it { expect(page).to have_content(I18n.t(:thank_for_order)) }
                it { expect(page).to have_current_path(books_path) }
              end

              it { expect(page).to have_current_path(checking_path) }
            end

            it { expect(page).to have_current_path(checking_path) }
          end

          it { expect(page).to have_current_path(checking_path) }
        end

        it { expect(page).to have_current_path(checking_path) }
      end

      it { expect(page).to have_current_path(checking_path) }
    end

    context 'through login' do
      let(:user) { create(:user, password: '123QWEasd') }

      before do
        user.confirm
        page.set_rack_session(quantity_books: 2, current_cart: cart_with_book.order.id)
        visit check_login_path
        fill_in('user_email_login', with: user.email)
        fill_in('user[password]', with: user.password)
        click_button(I18n.t(:login_with_password))
        visit checking_path
      end

      it { expect(page).to have_current_path(checking_path) }
    end

    context 'without authentication' do
      let(:user) { create(:user) }

      before { visit checking_path }

      it { expect(page).to have_current_path(new_user_session_path) }
    end
  end
end
