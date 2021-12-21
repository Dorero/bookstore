# frozen_string_literal: true

RSpec.describe AuthorDecorator do
  let!(:author) { create(:author).decorate }

  describe '#name' do
    it { expect(author.name).to eq("#{author.first_name} #{author.last_name}") }
    it { expect(author).to be_decorated }
    it { expect(author).to be_a(Author) }
  end
end
