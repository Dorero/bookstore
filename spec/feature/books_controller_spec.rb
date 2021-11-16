# frozen_string_literal: true

RSpec.describe 'Books', type: :feature, js: true do
  let!(:books) { create_list(:book, 5) }

  describe '#index' do
    before { visit(books_path) }

    it { expect(page).to have_current_path(books_path) }
    it { expect(page.has_link?(I18n.t(:all_books))).to be_truthy }
  end

  describe '#show' do
    before { visit(book_path(books.first.id)) }

    it { expect(page).to have_current_path(book_path(books.first.id)) }
    it { expect(page).to have_content(books.first.name) }
    it { expect(page).to have_content(books.first.price) }
    it { expect(page).to have_content(books.first.description) }
    it { expect(page).to have_content(books.first.year) }
    it { expect(page).to have_content(books.first.dimensions) }
    it { expect(page).to have_content(books.first.materials.sub(' ', ', ')) }
  end
end
