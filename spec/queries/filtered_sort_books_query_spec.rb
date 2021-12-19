# frozen_string_literal: true

RSpec.describe FilteredSortBooksQuery do
  let!(:categories) { create_list(:category, 2) }
  let!(:book_alphabetical_asc) { create(:book, name: 'A', category: categories.first) }
  let!(:book_alphabetical_desc) { create(:book, name: 'Z', category: categories.first) }
  let!(:book_min_price) { create(:book, price: 0.00, category: categories.first) }
  let!(:book_max_price) { create(:book, price: 100.00, category: categories.first) }
  let!(:other_books) { create_list(:book, 2, category: categories.first) }

  describe '#call' do
    context 'when sorting and filtered by new' do
      let(:sort_new) { described_class.new(categories.first.id, SortBooksQuery::NEW).call }

      it { expect(sort_new).to be_a(ActiveRecord::Relation) }
      it { expect(sort_new.first).to eq(other_books.last) }
      it { expect(sort_new.first.category).to eq(other_books.last.category) }
    end

    context 'when sorting and filtered by price' do
      let(:sort_price_hight) { described_class.new(categories.first.id, SortBooksQuery::PRICE_HIGHT).call }
      let(:sort_price_low) { described_class.new(categories.first.id, SortBooksQuery::PRICE_LOW).call }

      it { expect(sort_price_hight).to be_a(ActiveRecord::Relation) }
      it { expect(sort_price_low).to be_a(ActiveRecord::Relation) }
      it { expect(sort_price_hight.first).to eq(book_max_price) }
      it { expect(sort_price_low.first).to eq(book_min_price) }
      it { expect(sort_price_hight.first.category).to eq(book_max_price.category) }
      it { expect(sort_price_low.first.category).to eq(book_min_price.category) }
    end

    context 'when sorting and filtered by alphabetical' do
      let(:sort_title_desc) { described_class.new(categories.first.id, SortBooksQuery::TITLE_DESC).call }
      let(:sort_title_asc) { described_class.new(categories.first.id, SortBooksQuery::TITLE_ASC).call }

      it { expect(sort_title_desc).to be_a(ActiveRecord::Relation) }
      it { expect(sort_title_asc).to be_a(ActiveRecord::Relation) }
      it { expect(sort_title_asc.first).to eq(book_alphabetical_asc) }
      it { expect(sort_title_desc.first).to eq(book_alphabetical_desc) }
      it { expect(sort_title_asc.first.category).to eq(book_alphabetical_asc.category) }
      it { expect(sort_title_desc.first.category).to eq(book_alphabetical_desc.category) }
    end
  end
end
