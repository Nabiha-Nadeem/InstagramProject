# frozen_string_literal: true

# model for posts
class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy, as: :imageable
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user_id, presence: true
end
