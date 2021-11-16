# frozen_string_literal: true

RSpec.describe BooksByCategoryQuery do
  let(:relation) { described_class.new(1).call }

  it 'should be relationship' do
    expect(relation).to be_a(ActiveRecord::Relation)
  end
end
