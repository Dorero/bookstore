# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :publishers
  has_many :books, through: :publishers
end
