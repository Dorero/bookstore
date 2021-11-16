# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    first_name { 'John' }
    last_name  { 'Doe' }
  end

  factory :book do
    name { 'One War' }
    description { 'This is a war!' }
  end
end
