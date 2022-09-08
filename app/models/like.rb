# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true

  belongs_to :user
  # belongs_to :post

  # validates :user_id, :post_id, presence: true
end
