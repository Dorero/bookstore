# frozen_string_literal: true

# == Schema Information
#
# Table name: author_books
#
#  id         :bigint           not null, primary key
#  author_id  :bigint
#  book_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AuthorBook < ApplicationRecord
  belongs_to :author, dependent: :destroy
  belongs_to :book, dependent: :destroy
end
