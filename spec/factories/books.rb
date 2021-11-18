# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  price       :decimal(, )
#  year        :string
#  dimensions  :string
#  materials   :string
#
FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
    price { rand(11.2...76.9).round(2) }
    year { rand(1521..2020) }
    height { rand(1.0...10.9).round(2) }
    width { rand(1.0...6.9).round(2) }
    depth { rand(1.0...5.0).round(2) }
    materials { FFaker::Product.product }
    category
  end
end
