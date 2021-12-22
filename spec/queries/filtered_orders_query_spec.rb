# frozen_string_literal: true

RSpec.describe FilteredOrdersQuery do
  let!(:user) { create(:user) }

  describe '#call' do
    context 'when filtering by complete orders' do
      let!(:orders) { create_pair(:order, user: user, status: :complete) }

      let(:filtered_by_complete) { described_class.new(:complete, user).call }

      it { expect(filtered_by_complete).to be_a(ActiveRecord::Relation) }
      it { expect(filtered_by_complete.length).to eq(2) }
      it { expect(filtered_by_complete.first).to eq(orders.first) }
    end

    context 'when filtered by in delivery orders' do
      let!(:orders) { create_pair(:order, user: user, status: :in_delivery) }

      let(:filtered_by_in_delivery) { described_class.new(:in_delivery, user).call }

      it { expect(filtered_by_in_delivery).to be_a(ActiveRecord::Relation) }
      it { expect(filtered_by_in_delivery.length).to eq(2) }
      it { expect(filtered_by_in_delivery.first).to eq(orders.first) }
    end

    context 'when filtered by delivered orders' do
      let!(:orders) { create_pair(:order, user: user, status: :delivered) }

      let(:filtered_by_delivered) { described_class.new(:delivered, user).call }

      it { expect(filtered_by_delivered).to be_a(ActiveRecord::Relation) }
      it { expect(filtered_by_delivered.length).to eq(2) }
      it { expect(filtered_by_delivered.first).to eq(orders.first) }
    end

    context 'when filtered by canceled orders' do
      let!(:orders) { create_pair(:order, user: user, status: :canceled) }

      let(:filtered_by_canceled) { described_class.new(:canceled, user).call }

      it { expect(filtered_by_canceled).to be_a(ActiveRecord::Relation) }
      it { expect(filtered_by_canceled.length).to eq(2) }
      it { expect(filtered_by_canceled.first).to eq(orders.first) }
    end
  end
end
