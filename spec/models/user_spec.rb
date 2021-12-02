# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  image                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  provider               :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  confirmation_sent_at   :datetime
#
RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'model relations' do
    it { is_expected.to have_one(:address) }
  end

  describe 'validate' do
    context 'not be valid without email' do
      before do
        subject.email = nil
      end

      it { expect(subject).not_to be_valid }
    end

    context 'not be valid without password' do
      before do
        subject.password = nil
      end

      it { expect(subject).not_to be_valid }
    end

    context 'valid with attributes' do
      before do
        subject.email = FFaker::Internet.email
        subject.password = '1234QWEasd'
      end

      it { expect(subject).to be_valid }
    end

    context 'check attributes presence' do
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end
  end
end
