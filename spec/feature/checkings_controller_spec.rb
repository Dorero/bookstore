# frozen_string_literal: true

RSpec.describe 'Checkings', type: :feature do
  describe '#check_address' do
    before { visit check_address_checking_path }

    it { expect(page).to have_current_path(check_address_checking_path) }
  end
end
