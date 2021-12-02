# frozen_string_literal: true

RSpec.describe 'Admin/Author', type: :feature, js: true do
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
    before { visit view_admin_review_path(review.id) }

    it { expect(page).to have_current_path(view_admin_review_path(review.id)) }
  end

  describe '#approved' do
    before do
      visit view_admin_review_path(review.id)
      click_link(I18n.t(:approved))
    end

    it { expect(page).to have_current_path(admin_reviews_path) }
    it { expect(page).to have_content(I18n.t(:review_approved)) }
  end

  describe '#rejected' do
    before do
      visit view_admin_review_path(review.id)
      click_link(I18n.t(:rejected))
    end

    it { expect(page).to have_current_path(admin_reviews_path) }
    it { expect(page).to have_content(I18n.t(:review_rejected)) }
  end
end
