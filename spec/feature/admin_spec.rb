RSpec.describe 'Admin', type: :feature, js: true do
  let!(:admin) { create(:admin_user)}

  before do
    sign_in admin
  end

  describe 'GET #index' do
    context 'list authors' do
      before { visit admin_authors_path }

      it { expect(page).to have_current_path(admin_authors_path) }
    end

    context 'list books' do
      before { visit admin_books_path }

      it { expect(page).to have_current_path(admin_books_path) }
    end

    context 'list categories' do
      before { visit admin_categories_path }

      it { expect(page).to have_current_path(admin_categories_path) }
    end
  end

  describe 'GET #show' do
    context 'one author' do
      before { visit admin_authors_path }

      it { expect(page).to have_current_path(admin_authors_path) }
    end

    context 'one book' do
      before { visit admin_books_path }

      it { expect(page).to have_current_path(admin_books_path) }
    end

    context 'one category' do
      before { visit admin_categories_path }

      it { expect(page).to have_current_path(admin_categories_path) }
    end
  end

  describe 'GET #new' do
    context 'create author' do
      before { visit new_admin_author_path }

      it { expect(page).to have_current_path(new_admin_author_path) }
    end

    context 'create book' do
      before { visit new_admin_book_path }

      it { expect(page).to have_current_path(new_admin_book_path) }
    end

    context 'create category' do
      before { visit new_admin_category_path }

      it { expect(page).to have_current_path(new_admin_category_path) }
    end
  end

  describe 'GET #edit' do
    let!(:author) {create(:author)}
    let!(:book) {create(:book)}
    let!(:category) {create(:category)}

    context 'author' do
      before { visit edit_admin_author_path(author.id) }

      it { expect(page).to have_current_path(edit_admin_author_path(author.id)) }
    end

    context 'book' do
      before { visit edit_admin_book_path(book.id) }

      it { expect(page).to have_current_path(edit_admin_book_path(book.id)) }
    end

    context 'category' do
      before { visit edit_admin_category_path(category.id) }

      it { expect(page).to have_current_path(edit_admin_category_path(category.id)) }
    end
  end
end
