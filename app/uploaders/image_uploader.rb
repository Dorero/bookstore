# frozen_string_literal: true

class ImageUploader < Shrine
  plugin :activerecord
  plugin :cached_attachment_data
  plugin :restore_cached_data
  plugin :derivatives, create_on_promote: true

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      small: magick.resize_to_limit!(150, 150),
      medium: magick.resize_to_limit!(400, 300),
      large: magick.resize_to_limit!(900, 900)
    }
  end
end
