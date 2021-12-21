# frozen_string_literal: true

RSpec.describe 'Admin/Book', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:book) { create(:book) }

  let(:book_data) { attributes_for(:book) }

  before do
    sign_in admin
  end

  describe '#index' do
    before { visit admin_books_path }

    it { expect(page).to have_current_path(admin_books_path) }
  end

  describe '#show' do
    before { visit admin_book_path(book.id) }

    it { expect(page).to have_current_path(admin_book_path(book.id)) }
  end

  describe '#new' do
    before { visit new_admin_book_path }

    it { expect(page).to have_current_path(new_admin_book_path) }
  end

  describe '#edit' do
    before { visit edit_admin_book_path(book.id) }

    it { expect(page).to have_current_path(edit_admin_book_path(book.id)) }
  end

  describe '#update' do
    before do
      visit edit_admin_book_path(book.id)
      select book.category.name, from: 'book_category_id'
      fill_in 'book[name]', with: book_data[:name]
      fill_in 'book[description]', with: book_data[:description]
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

  describe '#delete' do
    before do
      visit admin_books_path
      accept_confirm { click_link(I18n.t(:delete_admin_button), href: admin_book_path(book.id)) }
    end

    it { expect(page).to have_content(I18n.t(:resource_success_delete, resource: 'Book')) }
    it { expect(page).to have_current_path(admin_books_path) }
  end

  describe '#create' do
    let(:path_to_file) { Rails.root.join('app/assets/images/seed/SmashingBook5ResponsiveWebDesign.jpg') }

    before do
      visit new_admin_book_path
      select book.category.name, from: 'book_category_id'
      fill_in 'book[name]', with: book_data[:name]
      fill_in 'book[description]', with: book_data[:description]
      fill_in 'book[price]', with: book_data[:price]
      fill_in 'book[year]', with: book_data[:year]
      fill_in 'book[height]', with: book_data[:height]
      fill_in 'book[width]', with: book_data[:width]
      fill_in 'book[depth]', with: book_data[:depth]
      fill_in 'book[materials]', with: book_data[:materials]
      click_link(I18n.t(:add_new_image))
      attach_file 'book[images_attributes][0][image]', path_to_file
      click_link(I18n.t(:add_new_image))
      attach_file 'book[images_attributes][1][image]', path_to_file
      click_button(I18n.t(:create_book))
    end

    it { expect(page).to have_content(I18n.t(:book_was_success_created)) }
  end
end
