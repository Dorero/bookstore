# frozen_string_literal: true

RSpec.describe 'Admin', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:author) { create(:author) }
  let!(:book) { create(:book) }
  let!(:category) { create(:category) }

  let(:author_data) { attributes_for(:author) }
  let(:book_data) { attributes_for(:book) }
  let(:category_data) { attributes_for(:category) }

  before do
    sign_in admin
  end

  describe '#index' do
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

  describe '#show' do
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

  describe '#new' do
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

  describe '#edit' do
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

  describe '#update' do
    context 'author' do
      before do
        visit edit_admin_author_path(author.id)
        fill_in 'author[first_name]', with: author_data[:first_name]
        fill_in 'author[last_name]', with: author_data[:last_name]
        fill_in 'author[description]', with: author_data[:description]
        click_button('commit')
      end

      it { expect(page).to have_current_path(admin_author_path(author.id)) }
    end

    context 'book' do
      before do
        visit edit_admin_book_path(book.id)
        select book.category.name, from: 'book_category_id'
        fill_in 'book[name]', with: book_data[:name]
        fill_in 'book[description]', with: book_data[:description]
        fill_in 'book[image]', with: book_data[:image]
        fill_in 'book[price]', with: book_data[:price]
        fill_in 'book[year]', with: book_data[:year]
        fill_in 'book[height]', with: book_data[:height]
        fill_in 'book[width]', with: book_data[:width]
        fill_in 'book[depth]', with: book_data[:depth]
        fill_in 'book[materials]', with: book_data[:materials]
        click_button('commit')
      end

      it { expect(page).to have_current_path(admin_book_path(book.id)) }
    end

    context 'category' do
      before do
        visit edit_admin_category_path(category.id)
        fill_in 'category[name]', with: category_data[:name]
        click_button('commit')
      end

      it { expect(page).to have_current_path(admin_category_path(category.id)) }
    end
  end

  describe '#delete' do
    context 'author' do
      before do
        visit admin_authors_path
        click_link('Delete', href: admin_author_path(author.id))
      end

      it { expect(page).to have_content(I18n.t(:resource_success_delete, resource: 'Author')) }
      it { expect(page).to have_current_path(admin_authors_path) }
    end

    context 'book' do
      before do
        visit admin_books_path
        click_link('Delete', href: admin_book_path(book.id))
      end

      it { expect(page).to have_content(I18n.t(:resource_success_delete, resource: 'Book')) }
      it { expect(page).to have_current_path(admin_books_path) }
    end

    context 'category' do
      before do
        visit admin_categories_path
        click_link('Delete', href: admin_category_path(category.id))
      end

      it { expect(page).to have_content(I18n.t(:resource_success_delete, resource: 'Category')) }
      it { expect(page).to have_current_path(admin_categories_path) }
    end
  end
end
