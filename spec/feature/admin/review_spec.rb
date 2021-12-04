# frozen_string_literal: true

RSpec.describe 'Admin/Review', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:review) { create(:review) }

  before do
    sign_in admin
  end

  describe '#index' do
    before { visit admin_reviews_path }

    it { expect(page).to have_current_path(admin_reviews_path) }
  end

  describe '#view' do
    before { visit admin_review_path(review.id) }

    it { expect(page).to have_current_path(admin_review_path(review.id)) }
  end

  describe '#approved' do
    before do
      visit admin_review_path(review.id)
      accept_confirm(I18n.t(:approve_review_confirm)) { click_link(I18n.t(:approve_button)) }
    end

    it { expect(page).to have_current_path(admin_reviews_path) }
    it { expect(page).to have_content(I18n.t(:review_approved_flash)) }
  end

  describe '#rejected' do
    before do
      visit admin_review_path(review.id)
      accept_confirm(I18n.t(:reject_review_confirm)) { click_link(I18n.t(:reject_button)) }
    end

    it { expect(page).to have_current_path(admin_reviews_path) }
    it { expect(page).to have_content(I18n.t(:review_rejected_flash)) }
  end
end
