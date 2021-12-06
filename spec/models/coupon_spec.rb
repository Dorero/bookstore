# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id         :bigint           not null, primary key
#  discount   :integer          default(3)
#  number     :string           default("59cfe1b30f1062bafda3bcf943b49bee")
#  status     :integer          default("ready")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sale_id    :bigint
#
# Indexes
#
#  index_coupons_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
RSpec.describe Coupon, type: :model do
  describe 'model relations' do
    it { is_expected.to belong_to(:sale) }
  end
end
