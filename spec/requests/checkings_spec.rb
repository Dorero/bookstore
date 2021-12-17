# frozen_string_literal: true

RSpec.describe 'Checkings', type: :request do
  let!(:cart_with_book) { create(:saved_book) }

  describe 'GET #show' do
    context 'through quick register' do
      let(:user_data) { attributes_for(:user) }

      before do
        post cart_path, params: { book_id: cart_with_book.book.id }
        post quick_register_check_login_path, params: { user: { email: user_data[:email] } }
        get checking_path
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'through login' do
      let(:user) { create(:user, password: '123QWEasd') }

      before do
        user.confirm
        post cart_path, params: { book_id: cart_with_book.book.id }
        post login_check_login_path, params: { user: { email: user.email, password: user.password } }
      end

      context 'check address state' do
        before { get checking_path }

        it { expect(response).to have_http_status(:success) }
      end

      context 'after check address' do
        let!(:delivery) { create(:delivery) }

        let(:payment) { attributes_for(:payment) }
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

        context 'check delivery state' do
          before { get checking_path }

          it { expect(response).to have_http_status(:success) }
        end

        context 'check payment state' do
          before do
            put checking_path, params: { delivery: { id: delivery.id } }
            get checking_path
          end

          it { expect(response).to have_http_status(:success) }
        end

        context 'check confirm state' do
          before do
            put checking_path, params: { delivery: { id: delivery.id } }
            put checking_path, params: { payment: { number: payment[:number], name: payment[:name],
                                                    expiration_date: payment[:expiration_date], cvv: payment[:cvv] } }
            get checking_path
          end

          it { expect(response).to have_http_status(:success) }
        end

        context 'check complete state' do
          before do
            put checking_path, params: { delivery: { id: delivery.id } }
            put checking_path, params: { payment: { number: payment[:number], name: payment[:name],
                                                    expiration_date: payment[:expiration_date], cvv: payment[:cvv] } }
            put checking_path
            get checking_path
          end

          it { expect(response).to have_http_status(:success) }
        end
      end

      it { expect(response).to redirect_to(checking_path) }
    end

    context 'without authentication' do
      let(:user) { create(:user) }

      before do
        post cart_path, params: { book_id: cart_with_book.book.id }
        get checking_path
      end

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  describe 'PUT #update' do
    context 'through quick register' do
      let(:user_data) { attributes_for(:user) }

      before do
        post cart_path, params: { book_id: cart_with_book.book.id }
        post quick_register_check_login_path, params: { user: { email: user_data[:email] } }
      end

      context 'check address state' do
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

        context 'after check address' do
          let!(:delivery) { create(:delivery) }

          let(:payment) { attributes_for(:payment) }

          context 'check delivery state' do
            before { put checking_path, params: { delivery: { id: delivery.id } } }

            it { expect(response).to redirect_to(checking_path) }
          end

          context 'check payment state' do
            before do
              put checking_path, params: { delivery: { id: delivery.id } }
              put checking_path, params: { payment: { number: payment[:number], name: payment[:name],
                                                      expiration_date: payment[:expiration_date], cvv: payment[:cvv] } }
            end

            it { expect(response).to redirect_to(checking_path) }
          end

          context 'check confirm state' do
            before do
              put checking_path, params: { delivery: { id: delivery.id } }
              put checking_path, params: { payment: { number: payment[:number], name: payment[:name],
                                                      expiration_date: payment[:expiration_date], cvv: payment[:cvv] } }
              put checking_path
            end

            it { expect(response).to redirect_to(checking_path) }
          end
        end

        it { expect(response).to have_http_status(:found) }
      end

      it { expect(response).to redirect_to(checking_path) }
    end
  end
end
