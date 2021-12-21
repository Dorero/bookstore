# frozen_string_literal: true

RSpec.describe 'CheckDeliveryService', type: :request do
  let!(:order_with_book) { create(:saved_book) }
  let!(:delivery) { create(:delivery) }

  let(:user_data) { attributes_for(:user) }
  let(:address_data) { attributes_for(:address) }
  let(:country) { 'DE' }

  before do
    post cart_path, params: { book_id: order_with_book.book.id }
    post quick_register_check_login_path, params: { user: { email: user_data[:email] } }
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

  describe 'GET #show' do
    before { get checking_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'PUT #update' do
    before { put checking_path, params: { delivery: { id: delivery.id } } }

    it { expect(response).to redirect_to(checking_path) }
  end
end
