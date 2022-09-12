# frozen_string_literal: true

# pages model
class Page < User
  has_many :user_page_relationships, foreign_key: :page_id
  has_many :accounts, through: :user_page_relationships

  def user_role(user_id)
    UserPageRelationship.find_by(user_id: user_id, page_id: self.id).role
  end
end
