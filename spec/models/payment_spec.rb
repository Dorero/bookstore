# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  cvv             :integer
#  expiration_date :string
#  name            :string
#  number          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_id        :bigint
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
require 'rails_helper'

RSpec.describe Payment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
