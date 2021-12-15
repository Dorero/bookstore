# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  city       :string           not null
#  country    :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  phone      :string           not null
#  place_type :string
#  type       :string           not null
#  zip        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint
#  place_id   :bigint
#  user_id    :bigint           not null
#
# Indexes
#
#  index_addresses_on_order_id  (order_id)
#  index_addresses_on_place     (place_type,place_id)
#  index_addresses_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#

RSpec.describe ShippingAddress, type: :model do
  describe 'model relations shipping address' do
    it { is_expected.to belong_to(:place) }
  end
end
