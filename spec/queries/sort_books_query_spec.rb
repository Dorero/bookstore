# frozen_string_literal: true

RSpec.describe SortBooksQuery do
  let!(:book_alphabetical_asc) { create(:book, name: 'A') }
  let!(:book_alphabetical_desc) { create(:book, name: 'Z') }
  let!(:book_min_price) { create(:book, price: 0.00) }
  let!(:book_max_price) { create(:book, price: 100.00) }
  let!(:new_book) { create(:book) }

  let(:sort_new) { described_class.new(NEW).call }
  let(:sort_price_hight) { described_class.new(PRICE_HIGHT).call }
  let(:sort_price_low) { described_class.new(PRICE_LOW).call }
  let(:sort_title_desc) { described_class.new(TITLE_DESC).call }
  let(:sort_title_asc) { described_class.new(TITLE_ASC).call }

  describe 'should be relationship' do
    it { expect(sort_new).to be_a(ActiveRecord::Relation) }
    it { expect(sort_price_hight).to be_a(ActiveRecord::Relation) }
    it { expect(sort_price_low).to be_a(ActiveRecord::Relation) }
    it { expect(sort_title_desc).to be_a(ActiveRecord::Relation) }
    it { expect(sort_title_asc).to be_a(ActiveRecord::Relation) }
  end

  describe 'should be correct order' do
    it { expect(sort_new.first).to eq(new_book) }
    it { expect(sort_price_hight.first).to eq(book_max_price) }
    it { expect(sort_price_low.first).to eq(book_min_price) }
    it { expect(sort_title_asc.first).to eq(book_alphabetical_asc) }
    it { expect(sort_title_desc.first).to eq(book_alphabetical_desc) }
  end
end
