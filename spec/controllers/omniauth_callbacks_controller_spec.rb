RSpec.describe Users::OmniauthCallbacksController do
  subject {described_class.new}

  describe '#failure' do
    it {allow(subject).to receive(:failure).once}
    it {allow(subject).to receive(:failure).once}
  end

  describe '#facebook' do
    it {allow(subject).to receive(:facebook).once}
  end
end

