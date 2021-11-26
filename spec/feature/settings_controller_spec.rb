RSpec.describe 'Settings', type: :feature, js: true do
  let!(:user) { create(:user, password: '123QWEasd') }

  describe '#edit' do
    context 'update billing address' do
      before do
        user.confirm
        sign_in user
        visit(edit_setting_path)
        fill_in('First Name', with: FFaker::Name.first_name)
        fill_in('Last Name', with: FFaker::Name.last_name)
        fill_in('Address', with: FFaker::Address.street_address)
        fill_in('City', with: FFaker::Address.city)
        fill_in('Country', with: FFaker::Address.city)
        fill_in('Zip', with: FFaker::AddressBR.zip_code)
        fill_in('Phone', with: FFaker::PhoneNumberDE.international_mobile_phone_number)
        click_button('Save')
      end

      it { expect(page).to have_current_path(edit_setting_path) }
    end
  end
end
