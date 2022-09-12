# frozen_string_literal: true

class UserPageRelationship < ApplicationRecord
  belongs_to :account, foreign_key: 'user_id', class_name: 'Account'
  belongs_to :page, foreign_key: 'page_id', class_name: 'Page'
  enum role: { admin: 0, editor: 1 }
end
