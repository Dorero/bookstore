# frozen_string_literal: true

FactoryBot.define do
  factory :author_book do
    author
    book
  end
end
