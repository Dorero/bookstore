# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  aasm_state  :string
#  completed   :datetime
#  number      :string
#  status      :integer          default("in_stock")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coupon_id   :bigint
#  delivery_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_orders_on_coupon_id    (coupon_id)
#  index_orders_on_delivery_id  (delivery_id)
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
    state :checking_address, :checking_delivery, :checking_payment, :checking_confirm, :checking_complete, :complete

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

    event :finish do
      transitions from: :checking_complete, to: :complete
    end

    event :back_to_address do
      transitions from: :checking_confirm, to: :checking_address
    end

    event :back_to_delivery do
      transitions from: :checking_confirm, to: :checking_delivery
    end

    event :back_to_payment do
      transitions from: :checking_confirm, to: :checking_payment
    end
  end

  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_one :payment

  has_one :billing_address, as: :addressed
  has_one :shipping_address, as: :addressed

  has_many :saved_books, dependent: :destroy
  has_many :books, through: :saved_books

  enum status: { in_stock: 0, in_progress: 1, in_queue: 2, in_delivery: 3, delivered: 4, canceled: 5 }
end
