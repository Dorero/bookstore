# frozen_string_literal: true

RSpec.describe FilteredOrdersQuery, type: :controller do
  let!(:user) { create(:user) }

  before do
    user.confirm
    sign_in user
  end

  describe '#call' do
    context 'when filtering by complete orders' do
      let(:filtered_by_complete) { described_class.new(:complete, user).call }

      it { expect(filtered_by_complete).to be_a(ActiveRecord::Relation) }
    end

    context 'when filtered by in delivery orders' do
      let(:filtered_by_in_delivery) { described_class.new(:in_delivery, user).call }

      it { expect(filtered_by_in_delivery).to be_a(ActiveRecord::Relation) }
    end

    context 'when filtered by delivered orders' do
      let(:filtered_by_delivered) { described_class.new(:delivered, user).call }

      it { expect(filtered_by_delivered).to be_a(ActiveRecord::Relation) }
    end

    context 'when filtered by canceled orders' do
      let(:filtered_by_canceled) { described_class.new(:canceled, user).call }

      it { expect(filtered_by_canceled).to be_a(ActiveRecord::Relation) }
    end
  end
end
