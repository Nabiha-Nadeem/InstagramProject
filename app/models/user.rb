# frozen_string_literal: true

# User class to handle accounts of users
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follows, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships
  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :following_relationships

  scope :with_stories, -> { where('EXISTS(SELECT * FROM stories WHERE user_id = users.id)') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, presence: true, length: {maximum: 50}

  has_one_attached :avatar

  after_commit :add_default_avatar, on: %i[create update]

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '150x150!').processed
    else
      '/default-avatar.jpg'
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default-avatar.jpg'
          )
        ), filename: 'default-avatar.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
