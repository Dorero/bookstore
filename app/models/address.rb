# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  type       :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  address    :string           not null
#  city       :string           not null
#  zip        :string           not null
#  country    :string           not null
#  phone      :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Address < ApplicationRecord
  belongs_to :user
end
