# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  message    :string
#  stars      :string
#  status     :integer          default("unprocessed")
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reviews_on_book_id  (book_id)
#  index_reviews_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  enum status: { unprocessed: 0, approved: 1, rejected: 2 }
end
