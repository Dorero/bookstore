# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Author, type: :model do
  describe 'model relations' do
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to have_many(:books).through(:author_books) }
  end
end
