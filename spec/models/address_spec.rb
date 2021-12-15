# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id             :bigint           not null, primary key
#  address        :string           not null
#  addressed_type :string
#  city           :string           not null
#  country        :string           not null
#  first_name     :string           not null
#  is_one_table   :integer          default(0)
#  last_name      :string           not null
#  phone          :string           not null
#  type           :string           not null
#  zip            :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  addressed_id   :bigint
#
# Indexes
#
#  index_addresses_on_addressed  (addressed_type,addressed_id)
#

RSpec.describe Address, type: :model do
  describe 'model relations address' do
    it { is_expected.to belong_to(:place) }
  end
end
