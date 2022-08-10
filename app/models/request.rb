# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :sender, foreign_key: 'user_id', class_name: 'User'
  belongs_to :sending, foreign_key: 'following_id', class_name: 'User'

  scope :pending_requests, ->(id) { where(following_id: id) }
end
