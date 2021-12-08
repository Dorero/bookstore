# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  aasm_state :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  coupon_id  :bigint
#
# Indexes
#
#  index_orders_on_coupon_id  (coupon_id)
#
class Order < ApplicationRecord
  include AASM

  aasm do
    state :cart, initial: true
  end

  belongs_to :coupon, optional: true
  has_many :saved_books, dependent: :destroy
  has_many :books, through: :saved_books
end
