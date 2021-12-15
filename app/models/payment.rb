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
#
class Payment < ApplicationRecord
  has_one :order
end
