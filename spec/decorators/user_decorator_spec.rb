# frozen_string_literal: true

RSpec.describe UserDecorator do
  let!(:user) { create(:user).decorate }

  let(:user_name) { "#{user.first_name} #{user.last_name}" }

  describe 'immutability' do
    it { expect(user).to be_decorated }
    it { expect(user).to be_a(User) }
  end

  describe '#name' do
    it { expect(user.name).to eq(user_name) }
  end

  describe '#image_letter' do
    it { expect(user.image_letter).to eq(user.email.first.capitalize) }
  end

  describe '#show_email_or_name' do
    it {
      expect(user.show_email_or_name).to eq((user_name.length > 1 ? user_name : user.email.first.capitalize).to_s)
    }
  end
end
