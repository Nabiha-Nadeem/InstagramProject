# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy, as: :likeable

  validates :user_id, :post_id, :body, presence: true
end
