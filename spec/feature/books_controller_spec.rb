# frozen_string_literal: true

RSpec.describe 'Books', type: :feature, js: true do
  let!(:book) { create(:image).book }

  describe '#index' do
    before { visit(books_path) }

    it { expect(page).to have_current_path(books_path) }
    it { expect(page).to have_link(I18n.t(:all_books)) }
  end

  describe '#show' do
    before do
      visit(book_path(book.id))
      if book.description.length > BooksController::MAX_SIZE_DESCRIPTION
        book.description = book.description[0...BooksController::MAX_SIZE_DESCRIPTION]
      end
    end

    it { expect(page).to have_current_path(book_path(book.id)) }
    it { expect(page).to have_content(book.name) }
    it { expect(page).to have_content(book.price) }
    it { expect(page).to have_content(book.description) }
    it { expect(page).to have_content(book.year) }
    it { expect(page).to have_content(book.height) }
    it { expect(page).to have_content(book.width) }
    it { expect(page).to have_content(book.depth) }
    it { expect(page).to have_content(book.decorate.materials) }
  end
end
