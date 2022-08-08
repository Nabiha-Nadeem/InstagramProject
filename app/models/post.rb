# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy, as: :imageable
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
