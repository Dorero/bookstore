# frozen_string_literal: true

# == Schema Information
#
# Table name: deliveries
#
#  id                    :bigint           not null, primary key
#  max_duration_delivery :integer
#  method                :string
#  min_duration_delivery :integer
#  price                 :decimal(8, 2)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
FactoryBot.define do
  factory :delivery do
    price { rand(20) }
    min_duration_delivery { rand(5) }
    max_duration_delivery { rand(20) }
  end
end
