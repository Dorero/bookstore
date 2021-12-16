# frozen_string_literal: true

RSpec.describe 'Addresses', type: :request do
  describe 'PUT #update' do
    let!(:user) { create(:user, password: '123QWEasd') }
    let!(:cart_with_book) { create(:saved_book) }

    before do
      user.confirm
      sign_in user
      post cart_path, params: { book_id: cart_with_book.book.id }
      put address_path, params: {
        'address' => { 'billing_address' => { 'addressed_id' => '1', 'addressed_type'=>'Order', 'first_name'=>'Domeno', 
                                            'last_name' => 'Arch', 'address'=>'Penza', 'city'=>'Ruza', 'zip'=>'45923', 
                                            'country' => 'DE', 'phone'=>'+493775913127', 'is_one_table'=>'0' }, 
                      'shipping_address' => { 'addressed_id' => '1', 'addressed_type'=>'Order', 'first_name'=>'QWer', 
                                             'last_name' => 'Asdasd', 'address'=>'Moscow', 'city'=>'Ruza', 'zip'=>'45923', 
                                             'country' => 'DE', 'phone'=>'+493775913127' } }, 'commit'=>'Continue'
      }
    end

    it { expect(response).to have_http_status(:found) }
  end
end
