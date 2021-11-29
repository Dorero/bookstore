RSpec.describe 'Admin', type: :request do
  let!(:admin) { create(:admin_user)}

  before do
    sign_in admin
  end

  describe 'GET #index' do
    context 'list authors' do
      before { get admin_authors_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'list books' do
      before { get admin_books_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'list categories' do
      before { get admin_categories_path }

      it { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #show' do
    context 'one author' do
      before { get admin_authors_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'one book' do
      before { get admin_books_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'one category' do
      before { get admin_categories_path }

      it { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #new' do
    context 'create author' do
      before { get new_admin_author_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'create book' do
      before { get new_admin_book_path }

      it { expect(response).to have_http_status(:success) }
    end

    context 'create category' do
      before { get new_admin_category_path }

      it { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #edit' do
    let!(:author) {create(:author)}
    let!(:book) {create(:book)}
    let!(:category) {create(:category)}

    context 'author' do
      before { get edit_admin_author_path(author.id) }

      it { expect(response).to have_http_status(:success) }
    end

    context 'book' do
      before { get edit_admin_book_path(book.id) }

      it { expect(response).to have_http_status(:success) }
    end

    context 'category' do
      before { get edit_admin_category_path(category.id) }

      it { expect(response).to have_http_status(:success) }
    end
  end
end
