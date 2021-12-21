# frozen_string_literal: true

RSpec.describe AddressDecorator do
  let!(:address) { create(:address).decorate }

  describe 'immutability' do
    it { expect(address).to be_decorated }
    it { expect(address).to be_a(Address) }
  end

  describe '#city_zip' do
    it { expect(address.city_zip).to eq("#{address.city} #{address.zip}") }
  end

  describe '#name' do
    it { expect(address.name).to eq("#{address.first_name} #{address.last_name}") }
  end
end
