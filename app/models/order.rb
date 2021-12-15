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
#  user_id    :bigint
#
# Indexes
#
#  index_orders_on_coupon_id  (coupon_id)
#  index_orders_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  include AASM

  aasm do
    state :cart, initial: true
    state :checking_address

    event :check_address do
      transitions from: :cart, to: :checking_address
    end

    event :to_cart do
      transitions from: :checking_address, to: :cart
    end
  end

  belongs_to :coupon, optional: true
  belongs_to :user, optional: true

  has_one :address, as: :place

  has_many :saved_books, dependent: :destroy
  has_many :books, through: :saved_books
end
