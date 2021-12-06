# frozen_string_literal: true

RSpec.describe 'Cart', type: :feature, js: true do
  let!(:book) { create(:book) }
  let!(:image) { create(:image, book: book) }

  describe '#show' do
    before do
      visit cart_path
    end

    it { expect(page).to have_current_path(cart_path) }
  end

  describe '#create' do
    before do
      visit book_path(book.id)
      find('.stars').click
      click_button(I18n.t(:add_to_cart))
    end

    it { expect(page).to have_content(I18n.t(:book_add_to_cart)) }
    it { expect(page).to have_current_path(book_path(book.id)) }
  end

  describe '#delete_book' do
    before do
      visit book_path(book.id)
      find('.stars').click
      click_button(I18n.t(:add_to_cart))
      visit cart_path
      find('.close').click
    end

    it { expect(page).to have_content(I18n.t(:book_success_delete)) }
    it { expect(page).to have_current_path(cart_path) }
  end

  describe '#check_coupon' do
    let!(:coupon) { create(:coupon) }

    before do
      visit cart_path
      fill_in(I18n.t(:enter_coupon), with: coupon.number)
      click_button(I18n.t(:apply_coupon))
    end

    it { expect(page).to have_content(I18n.t(:coupun_can_be_activated)) }
    it { expect(page).to have_current_path(cart_path) }
  end
end
