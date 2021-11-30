# frozen_string_literal: true

RSpec.describe 'Admin/Author', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:author) { create(:author) }

  let(:author_data) { attributes_for(:author) }

  before do
    sign_in admin
  end

  describe '#index' do
    before { visit admin_authors_path }

    it { expect(page).to have_current_path(admin_authors_path) }
  end

  describe '#show' do
    before { visit admin_authors_path }

    it { expect(page).to have_current_path(admin_authors_path) }
  end

  describe '#new' do
    before { visit new_admin_author_path }

    it { expect(page).to have_current_path(new_admin_author_path) }
  end

  describe '#edit' do
    before { visit edit_admin_author_path(author.id) }

    it { expect(page).to have_current_path(edit_admin_author_path(author.id)) }
  end

  describe '#update' do
    before do
      visit edit_admin_author_path(author.id)
      fill_in 'author[first_name]', with: author_data[:first_name]
      fill_in 'author[last_name]', with: author_data[:last_name]
      fill_in 'author[description]', with: author_data[:description]
      click_button('commit')
    end

    it { expect(page).to have_current_path(admin_author_path(author.id)) }
  end

  describe '#delete' do
    before do
      visit admin_authors_path
      click_link('Delete', href: admin_author_path(author.id))
    end

    it { expect(page).to have_content(I18n.t(:resource_success_delete, resource: 'Author')) }
    it { expect(page).to have_current_path(admin_authors_path) }
  end
end
