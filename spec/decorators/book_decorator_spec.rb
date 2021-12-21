# frozen_string_literal: true

RSpec.describe BookDecorator do
  let!(:order_with_book) { create(:saved_book) }
  let!(:book) { order_with_book.book.decorate }

  describe 'immutability' do
    it { expect(book).to be_decorated }
    it { expect(book).to be_a(Book) }
  end

  describe '#materials' do
    let!(:new_book) { create(:book) }

    it { expect(new_book.decorate.materials).to eq(new_book.materials.sub(' ', ', ')) }
  end

  describe '#dimensions' do
    let(:dimensions) do
      "#{I18n.t(:hegiht)}: #{book.height} x #{I18n.t(:width)}: #{book.width} x #{I18n.t(:depth)}: #{book.depth}"
    end

    it { expect(book.dimensions).to eq(dimensions) }
  end

  describe '#quantity' do
    it { expect(book.quantity).to eq(order_with_book.quantity) }
  end

  describe '#first_sentence' do
    it { expect(book.first_sentence).to eq(book.description.split('.').first) }
  end

  describe '#price_by_quantity' do
    it { expect(book.price_by_quantity).to eq(order_with_book.quantity * order_with_book.price) }
  end
end
