# frozen_string_literal: true

RSpec.describe SaleBook, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:sale) }
    it { is_expected.to belong_to(:book) }
  end
end
