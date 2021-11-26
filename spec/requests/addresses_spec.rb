RSpec.describe "Addresses", type: :request do
  describe 'PUT #update' do
    let!(:user) { create(:user, password: '123QWEasd')}

    before do
      user.confirm
      sign_in user
      put address_path, params: {
        id: user.id, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name,
        address: FFaker::Address.street_address, city: FFaker::Address.city, country: FFaker::Address.country,
        zip: FFaker::AddressBR.zip_code, phone: FFaker::PhoneNumberDE.international_mobile_phone_number
      }
    end

    it { expect(response).to have_http_status(:success) }
  end
end
