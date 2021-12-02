# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  title      :string
#  message    :string
#  stars      :string
#  status     :string           default("Unprocessed")
#  user_id    :bigint           not null
#  book_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Review, type: :model do
  describe 'model relations Review' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end
end
