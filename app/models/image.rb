# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  image_data :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#
# Indexes
#
#  index_images_on_book_id  (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#
class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :book
end
