# frozen_string_literal: true

RSpec.describe 'CheckCompleteService', type: :request do
  let!(:order_with_book) { create(:saved_book) }
  let!(:delivery) { create(:delivery) }

  let(:user_data) { attributes_for(:user) }
  let(:address_data) { attributes_for(:address) }
  let(:payment) { attributes_for(:payment) }

  before do
    post cart_path, params: { book_id: order_with_book.book.id }
    post quick_register_check_login_path, params: { user: { email: user_data[:email] } }
    put address_path, params: {
      'address' => { 'billing_address' => { 'addressed_id' => session[:current_cart], 'addressed_type' => 'Order',
                                            'first_name' => address_data[:first_name],
                                            'last_name' => address_data[:last_name],
                                            'address' => address_data[:address],
                                            'city' => address_data[:city], 'zip' => address_data[:zip],
                                            'country' => 'DE', 'phone' => address_data[:phone],
                                            'is_one_table' => 1 } }
    }
    put checking_path, params: { delivery: { id: delivery.id } }
    put checking_path, params: { payment: { number: payment[:number], name: payment[:name],
                                            expiration_date: payment[:expiration_date], cvv: payment[:cvv] } }
    put checking_path
  end

  describe 'GET #show' do
    before { get checking_path }

    it { expect(response).to have_http_status(:success) }
  end
end
