# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :category
  has_many :publishers
  has_many :authors, through: :publishers, dependent: :destroy
end
