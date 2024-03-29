# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id          :bigint           not null, primary key
#  first_name  :string
#  last_name   :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books
end
