# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id          :bigint           not null, primary key
#  first_name  :string
#  last_name   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#
FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
  end
end
