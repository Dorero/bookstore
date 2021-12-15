# frozen_string_literal: true

RSpec.describe 'Review', type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:image) { create(:image, book: book) }

  let(:review_data) { attributes_for(:review) }

  describe '#create' do
    before do
      sign_in user
      user.confirm
      visit book_path(book.id)
      find('.stars').click
      fill_in('review[title]', with: review_data[:title])
      fill_in('review[message]', with: review_data[:message])
      click_button(I18n.t(:post))
    end

    it { expect(page).to have_content(I18n.t(:thanks_for_review)) }
    it { expect(page).to have_current_path(book_path(book.id)) }
  end
end
