# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  title      :string
#  message    :string
#  stars      :string
#  status     :string           default("Unprocessed")
#  user_id    :bigint           not null
#  book_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    message { FFaker::Book.description }
    user
    book
  end
end
