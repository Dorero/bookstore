# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  aasm_state  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coupon_id   :bigint
#  delivery_id :bigint
#  payment_id  :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_orders_on_coupon_id    (coupon_id)
#  index_orders_on_delivery_id  (delivery_id)
#  index_orders_on_payment_id   (payment_id)
#  index_orders_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  include AASM

  aasm do
    state :cart, initial: true
    state :checking_address, :checking_delivery, :checking_payment, :checking_confirm, :checking_complete

    event :check_address do
      transitions from: :cart, to: :checking_address
    end

    event :check_delivery do
      transitions from: :checking_address, to: :checking_delivery
    end

    event :check_payment do
      transitions from: :checking_delivery, to: :checking_payment
    end

    event :check_confirm do
      transitions from: :checking_payment, to: :checking_confirm
    end

    event :check_complete do
      transitions from: :checking_confirm, to: :checking_complete
    end
  end

  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :payment, optional: true

  has_one :address, as: :addressed

  has_many :saved_books, dependent: :destroy
  has_many :books, through: :saved_books
end
