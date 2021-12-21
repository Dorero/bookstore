# frozen_string_literal: true

RSpec.describe BestsellersBooksQuery do
  subject(:relation) { described_class.new.call }

  describe '#call' do
    it { expect(relation).to be_a(ActiveRecord::Relation) }
  end
end
