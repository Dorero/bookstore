# frozen_string_literal: true

RSpec.describe BooksController do
  describe 'catalog', type: :feature, js: true do
    before { visit(books_path) }
    it { expect(page).to have_current_path(books_path) }
    it { expect(page.has_link?(I18n.t(:all_books))).to be_truthy }
  end
end
