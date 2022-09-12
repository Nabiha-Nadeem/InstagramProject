# frozen_string_literal: true

# roles functionality
module Roles
  def save_role(user, page, role)
    @role = UserPageRelationship.create(user_id: user, page_id: page, role: role)
    if @role.save
      flash[:notice] = 'Saved'
    else
      flash[:alert] = @role.errors.full_messages
    end
  end

  def role_exists?(user, page)
    UserPageRelationship.exists?(user_id: user, page_id: page)
  end
end
