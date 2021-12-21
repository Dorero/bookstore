# frozen_string_literal: true

RSpec.describe OrderDecorator do
  let!(:order_with_book) { create(:saved_book) }
  let!(:order) { order_with_book.order.decorate }

  let(:sub_total_price) { order_with_book.quantity * order_with_book.price }
  let(:discount) { order.coupon.discount.to_f }
  let(:shipping) { order.shipping }

  describe 'immutability' do
    it { expect(order).to be_decorated }
    it { expect(order).to be_a(Order) }
  end

  describe '#sub_total_price' do
    it { expect(order.sub_total_price).to eq(sub_total_price) }
  end

  describe '#discount' do
    it { expect(order.discount).to eq(discount) }
  end

  describe '#shipping' do
    it { expect(order.shipping).to eq(order.delivery.price.to_f) }
  end

  describe '#title' do
    it { expect(order.title).to eq("#{I18n.t(:order)} #{order.number}") }
  end

  describe '#order_total_price' do
    it { expect(order.order_total_price).to eq((sub_total_price + shipping) - discount) }
  end
end
