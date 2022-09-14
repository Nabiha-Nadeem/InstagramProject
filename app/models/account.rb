# frozen_string_literal: true

class Account < User
  has_many :user_page_relationships, foreign_key: :user_id, inverse_of: :account
  has_many :pages, through: :user_page_relationships
end
