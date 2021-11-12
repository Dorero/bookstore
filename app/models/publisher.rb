# frozen_string_literal: true

class Publisher < ApplicationRecord
  belongs_to :author, dependent: :destroy
  belongs_to :book, dependent: :destroy
end
