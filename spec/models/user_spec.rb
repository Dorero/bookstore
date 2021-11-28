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
