# frozen_string_literal: true

RSpec.describe FilteredSortBooksQuery do
  let!(:categories) { create_list(:category, 2) }
  let!(:book_alphabetical_asc) { create(:book, name: 'A', category: categories.first) }
  let!(:book_alphabetical_desc) { create(:book, name: 'Z', category: categories.first) }
  let!(:book_min_price) { create(:book, price: 0.00, category: categories.first) }
  let!(:book_max_price) { create(:book, price: 100.00, category: categories.first) }
  let!(:other_books) { create_list(:book, 5, category: categories.first) }
  let!(:books_other_category) { create_list(:book, 5, category: categories.last) }

  let(:sort_new) { described_class.new(categories.first.id, NEW).call }
  let(:sort_price_hight) { described_class.new(categories.first.id, PRICE_HIGHT).call }
  let(:sort_price_low) { described_class.new(categories.first.id, PRICE_LOW).call }
  let(:sort_title_desc) { described_class.new(categories.first.id, TITLE_DESC).call }
  let(:sort_title_asc) { described_class.new(categories.first.id, TITLE_ASC).call }

  describe 'should be relationship' do
    it { expect(sort_new).to be_a(ActiveRecord::Relation) }
    it { expect(sort_price_hight).to be_a(ActiveRecord::Relation) }
    it { expect(sort_price_low).to be_a(ActiveRecord::Relation) }
    it { expect(sort_title_desc).to be_a(ActiveRecord::Relation) }
    it { expect(sort_title_asc).to be_a(ActiveRecord::Relation) }
  end

  describe 'should be correct order' do
    it { expect(sort_new.first).to eq(other_books.last) }
    it { expect(sort_price_hight.first).to eq(book_max_price) }
    it { expect(sort_price_low.first).to eq(book_min_price) }
    it { expect(sort_title_asc.first).to eq(book_alphabetical_asc) }
    it { expect(sort_title_desc.first).to eq(book_alphabetical_desc) }
  end

  describe 'should be correct category' do
    it { expect(sort_new.first.category).to eq(other_books.last.category) }
    it { expect(sort_price_hight.first.category).to eq(book_max_price.category) }
    it { expect(sort_price_low.first.category).to eq(book_min_price.category) }
    it { expect(sort_title_asc.first.category).to eq(book_alphabetical_asc.category) }
    it { expect(sort_title_desc.first.category).to eq(book_alphabetical_desc.category) }
  end
end
