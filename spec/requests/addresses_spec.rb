# frozen_string_literal: true

RSpec.describe 'Addresses', type: :request do
  describe 'PUT #update' do
    let!(:user) { create(:user, password: '123QWEasd') }
    let!(:cart_with_book) { create(:saved_book) }

    let(:address_data) { attributes_for(:address) }
    let(:country) { 'DE' }

    before do
      user.confirm
      sign_in user
      post cart_path, params: { book_id: cart_with_book.book.id }
      put address_path, params: {
        'address' => { 'billing_address' => { 'addressed_id' => user.id, 'addressed_type' => 'User',
                                              'first_name' => address_data[:first_name],
                                              'last_name' => address_data[:last_name],
                                              'address' => address_data[:address],
                                              'city' => address_data[:city], 'zip' => address_data[:zip],
                                              'country' => country, 'phone' => address_data[:phone],
                                              'is_one_table' => address_data[:is_one_table] },
                       'shipping_address' => { 'addressed_id' => user.id, 'addressed_type' => 'User',
                                               'first_name' => address_data[:first_name],
                                               'last_name' => address_data[:last_name],
                                               'address' => address_data[:address],
                                               'city' => address_data[:city], 'zip' => address_data[:zip],
                                               'country' => country, 'phone' => address_data[:phone] } }
      }
    end

    it { expect(response).to redirect_to(edit_setting_path) }
  end
end
