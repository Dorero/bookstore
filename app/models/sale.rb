# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id             :bigint           not null, primary key
#  number         :string
#  quantity_books :integer
#  status         :integer          default(0)
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Sale < ApplicationRecord
  has_one :address
  has_one :coupon
  has_many :sale_books
  has_many :books, through: :sale_books
end
