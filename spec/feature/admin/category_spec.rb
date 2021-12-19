# frozen_string_literal: true

RSpec.describe 'Admin/Category', type: :feature, js: true do
  let!(:admin) { create(:admin_user) }
  let!(:category) { create(:category) }

  let(:category_data) { attributes_for(:category) }

  before do
    sign_in admin
  end

  describe '#index' do
    before { visit admin_categories_path }

    it { expect(page).to have_current_path(admin_categories_path) }
  end

  describe '#show' do
    before { visit admin_category_path(category.id) }

    it { expect(page).to have_current_path(admin_category_path(category.id)) }
  end

  describe '#new' do
    before { visit new_admin_category_path }

    it { expect(page).to have_current_path(new_admin_category_path) }
  end

  describe '#edit' do
    before { visit edit_admin_category_path(category.id) }

    it { expect(page).to have_current_path(edit_admin_category_path(category.id)) }
  end

  describe '#update' do
    before do
      visit edit_admin_category_path(category.id)
      fill_in 'category[name]', with: category_data[:name]
      click_button('commit')
    end

    it { expect(page).to have_current_path(admin_category_path(category.id)) }
  end

  describe '#delete' do
    before do
      visit admin_categories_path
      accept_confirm { click_link(I18n.t(:delete_admin_button), href: admin_category_path(category.id)) }
    end

    it { expect(page).to have_content(I18n.t(:resource_success_delete, resource: 'Category')) }
    it { expect(page).to have_current_path(admin_categories_path) }
  end
end
