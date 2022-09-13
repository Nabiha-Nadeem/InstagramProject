# frozen_string_literal: true

# policy for Posts
class PostPolicy < ApplicationPolicy
  def edit?
    record.user == user || record.user.user_role(user) == 'admin' || record.user.user_role(user) == 'editor'
  end

  def update?
    record.user == user || record.user.user_role(user) == 'admin' || record.user.user_role(user) == 'editor'
  end

  def destroy?
    record.user == user || record.user.user_role(user) == 'admin' || record.user.user_role(user) == 'editor'
  end
end
