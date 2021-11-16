# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :category
  has_many :publishers
  has_many :user_books
  has_many :authors, through: :publishers, dependent: :destroy
  has_many :users, through: :user_books
end
