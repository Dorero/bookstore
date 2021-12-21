# frozen_string_literal: true

RSpec.describe PaymentDecorator do
  let!(:payment) { create(:payment).decorate }

  describe '#number_card' do
    before { stub_const('LAST_CARD_NUMBER', 4) }

    it { expect(payment.number_card).to eq("** ** ** #{payment.number.to_s.last(LAST_CARD_NUMBER)}") }
    it { expect(payment).to be_decorated }
  end
end
