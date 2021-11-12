# frozen_string_literal: true

RSpec.describe HomePageController do
  describe '/index.haml', type: :feature, js: true do
    before { visit('/') }
    it { expect(page).to have_current_path('/') }
    it { expect(page).to have_content(I18n.t(:welcome)) }
    it { expect(page).to have_content(I18n.t(:phone)) }
    it { expect(page).to have_content(I18n.t(:email_support)) }
    it { expect(page.has_link?(I18n.t(:my_account))).to be_truthy }
  end
end
