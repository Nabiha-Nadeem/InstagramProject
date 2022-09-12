# frozen_string_literal: true

# model for photos
class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, PhotoUploader

  validate :check_image, on: :new

  def check_image
    return if image.filename

    raise StandardError, 'Please add an image!'
  end
end
