# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  type       :string
#  first_name :string
#  last_name  :string
#  address    :string
#  city       :string
#  zip        :string
#  country    :string
#  phone      :string
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RSpec.describe Address, type: :model do
  describe 'model relations address' do
    it { is_expected.to belong_to(:user) }
  end
end
