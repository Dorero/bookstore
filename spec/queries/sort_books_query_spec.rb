# frozen_string_literal: true

RSpec.describe SortBooksQuery do
  let!(:book_alphabetical_asc) { create(:book, name: 'A') }
  let!(:book_alphabetical_desc) { create(:book, name: 'Z') }
  let!(:book_min_price) { create(:book, price: 0.00) }
  let!(:book_max_price) { create(:book, price: 100.00) }
  let!(:new_book) { create(:book) }

  describe '#call' do
    context 'sort by new' do
      let(:sort_new) { described_class.new(described_class::NEW).call }

      it { expect(sort_new).to be_a(ActiveRecord::Relation) }
      it { expect(sort_new.first).to eq(new_book) }
    end

    context 'sort by price' do
      let(:sort_price_hight) { described_class.new(described_class::PRICE_HIGHT).call }
      let(:sort_price_low) { described_class.new(described_class::PRICE_LOW).call }

      it { expect(sort_price_hight).to be_a(ActiveRecord::Relation) }
      it { expect(sort_price_low).to be_a(ActiveRecord::Relation) }
      it { expect(sort_price_hight.first).to eq(book_max_price) }
      it { expect(sort_price_low.first).to eq(book_min_price) }
    end

    context 'sort by alphabetical' do
      let(:sort_title_desc) { described_class.new(described_class::TITLE_DESC).call }
      let(:sort_title_asc) { described_class.new(described_class::TITLE_ASC).call }

      it { expect(sort_title_desc).to be_a(ActiveRecord::Relation) }
      it { expect(sort_title_asc).to be_a(ActiveRecord::Relation) }
      it { expect(sort_title_asc.first).to eq(book_alphabetical_asc) }
      it { expect(sort_title_desc.first).to eq(book_alphabetical_desc) }
    end
  end
end
