# frozen_string_literal: true

# Photo uploader
class PhotoUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  include Cloudinary::CarrierWave

  process convert: 'png'
  process tags: ['post_picture']

  version :standard do
    process resize_to_fill: [450, 600, :north]
  end

  version :thumbnail do
    resize_to_fill(310, 310)
  end

  version :story do
    resize_to_fill(500, 800)
  end
end
