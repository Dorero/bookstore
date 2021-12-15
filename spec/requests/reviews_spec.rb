# frozen_string_literal: true

RSpec.describe 'Reviews', type: :request do
  let!(:admin) { create(:admin_user) }
  let!(:book) { create(:book) }
  let!(:user) { create(:user) }

  let(:data_for_review) { attributes_for(:review) }

  describe 'POST #create' do
    before do
      sign_in admin
      post review_path,
           params: { review: { title: data_for_review[:title], message: data_for_review[:message], user_id: user.id,
                               book_id: book.id } }
    end

    it { expect(response).to redirect_to(book_path(book.id)) }
  end
end
