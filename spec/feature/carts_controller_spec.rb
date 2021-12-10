# frozen_string_literal: true

RSpec.describe 'Cart', type: :feature, js: true do
  let!(:cart_with_book) { create(:saved_book) }
  let!(:image) { create(:image, book: cart_with_book.book) }

  context 'with create cart and add book' do
    before { page.set_rack_session(quantity_books: 2, current_cart: cart_with_book.order.id) }

    describe '#show' do
      before { visit cart_path }

      it { expect(page).to have_current_path(cart_path) }
    end

    describe '#delete_book' do
      before do
        visit book_path(cart_with_book.book.id)
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

      it { expect(page).to have_content(I18n.t(:coupon_applied)) }
      it { expect(page).to have_current_path(cart_path) }
    end

    describe '#increment_quantity_books' do
      before do
        visit cart_path
        find('.fa-plus').click
      end

      it { expect(page).to have_current_path(cart_path) }
    end

    describe '#decrement_quantity_books' do
      before do
        visit cart_path
        find('.fa-minus').click
      end

      it { expect(page).to have_current_path(cart_path) }
    end

    describe '#decrement_quantity_books' do
      before do
        visit cart_path
        find('.fa-minus').click
      end

      it { expect(page).to have_current_path(cart_path) }
    end

    describe '#update_prices' do
      before do
        visit cart_path
        find('.quantity-input').set(2)
      end

      it { expect(page).to have_current_path(cart_path) }
    end
  end

  context 'without create cart' do
    describe '#create' do
      before do
        visit book_path(cart_with_book.book.id)
        find('.stars').click
        click_button(I18n.t(:add_to_cart))
      end

      it { expect(page).to have_content(I18n.t(:book_add_to_cart)) }
      it { expect(page).to have_current_path(book_path(cart_with_book.book.id)) }
    end
  end
end
