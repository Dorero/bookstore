# frozen_string_literal: true

RSpec.describe 'CheckAddressService', type: :request do
  let!(:order_with_book) { create(:saved_book) }

  let(:user_data) { attributes_for(:user) }

  before do
    post cart_path, params: { book_id: order_with_book.book.id }
    post quick_register_check_login_path, params: { user: { email: user_data[:email] } }
    get checking_path
  end

  describe 'GET #show' do
    it { expect(response).to have_http_status(:success) }
  end

  describe 'PUT #update' do
    let(:address_data) { attributes_for(:address) }
    let(:country) { 'DE' }

    before do
      put address_path, params: {
        'address' => { 'billing_address' => { 'addressed_id' => session[:current_cart], 'addressed_type' => 'Order',
                                              'first_name' => address_data[:first_name],
                                              'last_name' => address_data[:last_name],
                                              'address' => address_data[:address],
                                              'city' => address_data[:city], 'zip' => address_data[:zip],
                                              'country' => country, 'phone' => address_data[:phone],
                                              'is_one_table' => 1 } }
      }
    end

    it { expect(response).to have_http_status(:found) }
  end
end
