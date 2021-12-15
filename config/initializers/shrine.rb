require "shrine"
require "shrine/storage/file_system"
require "image_processing/mini_magick"
require "shrine/storage/s3"
require 'shrine/storage/memory'

if Rails.env.test?
  Shrine.storages[:store] = Shrine::Storage::Memory.new
  Shrine.storages[:cache] = Shrine::Storage::Memory.new
end

if Rails.env.development?
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
  }
end

if Rails.env.production?
  s3_options = {
    bucket:            Rails.application.credentials.dig(:aws, :bucket),
    region:            Rails.application.credentials.dig(:aws, :region),
    access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),
    secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(**s3_options),
  }
end



