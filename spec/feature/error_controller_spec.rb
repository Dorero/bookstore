# frozen_string_literal: true

RSpec.describe 'Error', type: :feature, js: true do
  describe '#not_found' do
    before { visit(book_path('undefined')) }

    it { expect(page).to have_current_path('/404') }
  end
end
