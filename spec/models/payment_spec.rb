# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  cvv             :integer
#  expiration_date :string
#  name            :string
#  number          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :bigint
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#

RSpec.describe Payment, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:order) }
  end
end
