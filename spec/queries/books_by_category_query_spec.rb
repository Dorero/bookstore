# frozen_string_literal: true

RSpec.describe BooksByCategoryQuery do
  subject(:relation) { described_class.new(book.category.id).call }

  let!(:book) { create(:book) }

  it 'is relationship' do
    expect(relation).to be_a(ActiveRecord::Relation)
  end

  it { expect(relation.first).to eq(book) }
end
