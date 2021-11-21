# frozen_string_literal: true

RSpec.describe 'HomePage', type: :feature, js: true do
  describe '#show' do
    before { visit(root_path) }

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_content(I18n.t(:welcome)) }
    it { expect(page).to have_content(I18n.t(:phone)) }
    it { expect(page).to have_content(I18n.t(:email_support)) }
  end
end
