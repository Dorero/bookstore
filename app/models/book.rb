# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  depth       :string
#  description :text
#  height      :string
#  materials   :string
#  name        :string
#  price       :decimal(8, 2)
#  width       :string
#  year        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#
# Indexes
#
#  index_books_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Book < ApplicationRecord
  belongs_to :category
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :sale_books
  has_many :sales, through: :sale_books

  accepts_nested_attributes_for :images, allow_destroy: true
end
