# frozen_string_literal: true

RSpec.describe LatestBooksQuery do
  let!(:book_first) do
    create(:book, name: Faker::Books::CultureSeries.book, description: Faker::Books::Lovecraft.paragraph)
  end
  let!(:book_second) do
    create(:book, name: Faker::Books::CultureSeries.book, description: Faker::Books::Lovecraft.paragraph)
  end
  let(:relation) { described_class.new(1).call }

  it { expect(relation).to be_a(ActiveRecord::Relation) }
  it { expect(relation.length).to eq(1) }
  it { expect(relation.last).to eq(book_second) }
  it { expect(relation.last.name).to eq(book_second.name) }
end
