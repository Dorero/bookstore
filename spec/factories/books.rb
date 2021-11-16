# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
  end
end
