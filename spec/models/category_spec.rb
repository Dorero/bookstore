# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Category, type: :model do
  describe 'model relations category' do
    it { is_expected.to have_many(:books) }
  end
end
