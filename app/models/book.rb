# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  price       :decimal(8, 2)
#  year        :string
#  height      :string
#  width       :string
#  depth       :string
#  materials   :string
#
class Book < ApplicationRecord
  belongs_to :category
  has_many :publishers
  has_many :authors, through: :publishers, dependent: :destroy
end
