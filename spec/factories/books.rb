# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { 'Book' }
    description { 'Description' }
    association :category, factory: :category
  end
end
