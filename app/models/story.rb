# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy, as: :imageable

  validates :user_id, presence: true
end
