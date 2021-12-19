# frozen_string_literal: true

RSpec.describe LatestBooksQuery do
  subject(:relation) { described_class.new(1).call }

  let!(:book) { create(:book) }

  it { expect(relation).to be_a(ActiveRecord::Relation) }
  it { expect(relation.length).to eq(1) }
  it { expect(relation.last).to eq(book) }
end
