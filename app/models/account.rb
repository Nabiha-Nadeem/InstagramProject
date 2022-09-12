# frozen_string_literal: true

class Account < User
  has_many :user_page_relationships, foreign_key: :user_id
  has_many :pages, through: :user_page_relationships

  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
end
