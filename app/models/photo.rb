# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, PhotoUploader
end
