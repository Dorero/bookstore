# frozen_string_literal: true

# == Schema Information
#
# Table name: deliveries
#
#  id                    :bigint           not null, primary key
#  max_duration_delivery :integer
#  method                :string
#  min_duration_delivery :integer
#  price                 :decimal(8, 2)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

RSpec.describe Delivery, type: :model do
  describe 'model relations' do
    it { is_expected.to have_one(:order) }
  end
end
