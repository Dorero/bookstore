# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  image                  :string
#  last_name              :string           default(""), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'model relations' do
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
    it { is_expected.to have_one(:order) }
    it { is_expected.to have_many(:reviews) }
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
