# frozen_string_literal: true

RSpec.describe 'Checkings', type: :feature do
  describe '#check_address' do
    before { visit checking_path }

    it { expect(page).to have_current_path(checking_path) }
  end
end
