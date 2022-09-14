# frozen_string_literal: true

class UserPageRelationship < ApplicationRecord
  belongs_to :account, foreign_key: 'user_id', class_name: 'Account', inverse_of: :user_page_relationships
  belongs_to :page, foreign_key: 'page_id', class_name: 'Page', inverse_of: :user_page_relationships
  enum role: { admin: 0, editor: 1 }
end
