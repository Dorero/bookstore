# frozen_string_literal: true

RSpec.describe ErrorController do
  describe '#not_found' do
    subject { described_class.new }

    it { allow(subject).to receive(:not_found).once }
  end
end
