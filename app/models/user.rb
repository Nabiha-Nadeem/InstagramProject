# frozen_string_literal: true

# User class to handle accounts of users
class User < ApplicationRecord
  include Searchable

  has_many :posts, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :follows, dependent: :destroy
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships
  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :following_relationships

  has_many :requests, dependent: :destroy
  has_many :sender_relationships, foreign_key: :following_id, class_name: 'Request'
  has_many :senders, through: :sender_relationships
  has_many :sending_relationships, foreign_key: :user_id, class_name: 'Request'
  has_many :sending, through: :sending_relationships

  scope :with_stories, -> { where('EXISTS(SELECT * FROM stories WHERE user_id = users.id)') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, presence: true, length: { maximum: 50 }
  validates :is_private, inclusion: { in: [true, false] }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates_format_of :fullname, with: /\A[a-zA-Z.']+(?: [a-zA-Z.']+){0,4}\z/

  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(io: File.open(
      Rails.root.join(
        'app', 'assets', 'images', 'default-avatar.jpg'
      )
    ), filename: 'default-avatar.jpg',
                  content_type: 'image/jpg')
  end
end
