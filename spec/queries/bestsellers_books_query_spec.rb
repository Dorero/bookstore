# frozen_string_literal: true

RSpec.describe BestsellersBooksQuery do
  subject(:relation) { described_class.new.call }

  describe '#call' do
    context 'with complete orders' do
      let!(:orders) { create_pair(:order, status: :complete) }
      let!(:books) { create_list(:book, 5) }

      before do
        create(:saved_book, order: orders.first, book: books.first)
        create(:saved_book, order: orders.last, book: books.first)
        create(:saved_book, order: orders.last, book: books[1])
        create(:saved_book, order: orders.last, book: books[2])
        create(:saved_book, order: orders.last, book: books[3])
        create(:saved_book, order: orders.last, book: books.last)
      end

      it { expect(relation).to be_a(ActiveRecord::Relation) }
      it { expect(relation.length).to eq(4) }
      it { expect(relation.first).to eq(books.first) }
    end

    context 'without complete orders' do
      let!(:orders) { create_pair(:order) }
      let!(:books) { create_pair(:book) }

      before { create(:saved_book, order: orders.first, book: books.first) }

      it { expect(relation).to be_a(ActiveRecord::Relation) }
      it { expect(relation.length).to eq(0) }
    end
  end
end
