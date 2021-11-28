RSpec.describe 'Settings', type: :feature, js: true do
  describe '#edit' do
    let!(:user) { create(:user, password: '123QWEasd') }

    context 'success update data' do
      let(:address_data) { attributes_for(:address)}
      let(:user_data) {attributes_for(:user, password: '1234567890QWEasd')}

      context 'update billing address' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Address')
          fill_in('billing_address[first_name]', with: address_data[:first_name])
          fill_in('billing_address[last_name]', with: address_data[:last_name])
          fill_in('billing_address[address]', with: address_data[:address])
          fill_in('billing_address[city]', with: address_data[:city])
          select "Germany", :from => "billing_address[country]"
          fill_in('billing_address[zip]', with: address_data[:zip])
          fill_in('billing_address[phone]', with: address_data[:phone])
          click_button('billing_address_button')
        end

        it { expect(page).to have_current_path(edit_setting_path) }
      end

      context 'update shipping address' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Address')
          fill_in('shipping_address[first_name]', with: address_data[:first_name])
          fill_in('shipping_address[last_name]', with: address_data[:last_name])
          fill_in('shipping_address[address]', with: address_data[:address])
          fill_in('shipping_address[city]', with: address_data[:city])
          select "Germany", :from => "shipping_address[country]"
          fill_in('shipping_address[zip]', with: address_data[:zip])
          fill_in('shipping_address[phone]', with: address_data[:phone])
          click_button('shipping_address_button')
        end

        it { expect(page).to have_current_path(edit_setting_path) }
      end

      context 'update email' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Privacy')
          fill_in('user[email]', with: user_data[:email])
          click_button('email_button')
        end

        it { expect(page).to have_current_path(edit_setting_path(success_change_email: I18n.t(:'devise.mailer.email_changed.subject'))) }
      end

      context 'update password' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Privacy')
          fill_in('Old Password', with: user.password)
          fill_in('New Password', with: user_data[:password])
          fill_in('Confirm Password', with: user_data[:password])
          click_button('password_button')
        end

        it { expect(page).to have_current_path(new_user_session_path) }
      end
    end

    context 'failed update data' do
      let(:broken_address_data) { attributes_for(:address,
                                                 first_name: FFaker::Book.description, last_name: FFaker::Book.description,
                                                 city: FFaker::Book.description, country: FFaker::Book.description,
                                                 address: FFaker::Book.description, zip: FFaker::Name.first_name,
                                                 phone: FFaker::PhoneNumberJA.international_mobile_phone_number)}
      let(:broken_user_data) {attributes_for(:user, email: FFaker::Book.description, password: FFaker::Book.description)}

      context 'update billing address' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Address')
          fill_in('billing_address[first_name]', with: broken_address_data[:first_name])
          fill_in('billing_address[last_name]', with: broken_address_data[:last_name])
          fill_in('billing_address[address]', with: broken_address_data[:address])
          fill_in('billing_address[city]', with: broken_address_data[:city])
          select "Germany", :from => "billing_address[country]"
          fill_in('billing_address[zip]', with: broken_address_data[:zip])
          fill_in('billing_address[phone]', with: broken_address_data[:phone])
          click_button('billing_address_button')
        end

        it { expect(page).to have_text("is invalid")}
        it { expect(page).to have_current_path(edit_setting_path(billing_address_errors:
                                                                   {"first_name"=>"is invalid", "last_name"=>"is invalid",
                                                                    "city"=>"is invalid", "address"=>"is invalid",
                                                                    "zip"=>"is invalid",
                                                                    "phone"=>"is too long (maximum is 15 characters)"})) }
      end

      context 'update shipping address' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Address')
          fill_in('shipping_address[first_name]', with: broken_address_data[:first_name])
          fill_in('shipping_address[last_name]', with: broken_address_data[:last_name])
          fill_in('shipping_address[address]', with: broken_address_data[:address])
          fill_in('shipping_address[city]', with: broken_address_data[:city])
          select "Germany", :from => "shipping_address[country]"
          fill_in('shipping_address[zip]', with: broken_address_data[:zip])
          fill_in('shipping_address[phone]', with: broken_address_data[:phone])
          click_button('shipping_address_button')
        end

        it { expect(page).to have_text("is invalid")}
        it { expect(page).to have_current_path(edit_setting_path(shipping_address_errors:
                                                                   { "first_name" => "is invalid", "last_name" => "is invalid",
                                                                     "city" => "is invalid", "address" => "is invalid",
                                                                     "zip"=>"is invalid",
                                                                     "phone"=>"is too long (maximum is 15 characters)"})) }
      end

      context 'update email' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Privacy')
          fill_in('user[email]', with: broken_user_data[:email])
          click_button('email_button')
        end

        it { expect(page).to have_current_path(edit_setting_path(errors_email: ["is invalid", "is too long (maximum is 63 characters)"])) }
      end

      context 'update password' do
        before do
          user.confirm
          sign_in user
          visit(edit_setting_path)
          click_link('Privacy')
          fill_in('Old Password', with: user.password)
          fill_in('New Password', with: broken_user_data[:password])
          fill_in('Confirm Password', with: broken_user_data[:password])
          click_button('password_button')
        end

        it { expect(page).to have_current_path(edit_setting_path(errors_password: ["is invalid", "is too long (maximum is 128 characters)"])) }
      end
    end

    context 'delete account' do
      before do
        user.confirm
        sign_in user
        visit(edit_setting_path)
        click_link('Privacy')
        click_button('Please Remove My Account')
      end

      it { expect(page).to have_text(I18n.t(:'devise.registrations.destroyed'))}
      it { expect(page).to have_current_path(root_path) }
    end
  end
end
