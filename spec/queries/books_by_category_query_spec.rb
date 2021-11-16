# frozen_string_literal: true

RSpec.describe BooksByCategoryQuery do
  let!(:books) { create_list(:book, 4) }
  let!(:book) { create(:book) }
  let(:relation) { described_class.new(book.category.id).call }

  it 'should be relationship' do
    expect(relation).to be_a(ActiveRecord::Relation)
  end

  it { expect(relation.first).to eq(book) }
  it { expect(relation.first.category).to eq(book.category) }
end
