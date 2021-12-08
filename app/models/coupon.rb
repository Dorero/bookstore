# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id         :bigint           not null, primary key
#  discount   :decimal(8, 2)
#  number     :string
#  status     :integer          default("ready")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Coupon < ApplicationRecord
  has_one :order, dependent: :destroy

  enum status: { ready: 0, pre_use: 1, spent: 2 }
end
