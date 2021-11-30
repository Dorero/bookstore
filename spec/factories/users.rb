# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  image                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  provider               :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  confirmation_sent_at   :datetime
#
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.disposable_email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    image { FFaker::Image.url }
    password { FFaker::Internet.password }
    reset_password_token { FFaker::Internet.password }
  end
end
