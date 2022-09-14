# frozen_string_literal: true

# roles functionality
module Roles
  def save_role(user_id, page_id, assigned_role)
    role = UserPageRelationship.create(user_id: user_id, page_id: page_id, role: assigned_role)
    if role.save
      flash[:notice] = 'Saved'
    else
      flash[:alert] = role.errors.full_messages
    end
  end

  def role_exists?(user_id, page_id)
    UserPageRelationship.exists?(user_id: user_id, page_id: page_id)
  end
end
