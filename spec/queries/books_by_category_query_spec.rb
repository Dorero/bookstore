# frozen_string_literal: true

RSpec.describe BooksByCategoryQuery do
  let!(:book) { create(:book) }

  subject(:relation) { described_class.new(book.category.id).call }

  it 'should be relationship' do
    expect(relation).to be_a(ActiveRecord::Relation)
  end

  it { expect(relation.first).to eq(book) }
end
