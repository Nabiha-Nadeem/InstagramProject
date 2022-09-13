# frozen_string_literal: true

# policy for Pages
class PagePolicy < ApplicationPolicy
  def edit?
    record.user_role(user) == 'admin' or record.user_role(user) == 'editor'
  end

  def update?
    record.user_role(user) == 'admin' or record.user_role(user) == 'editor'
  end

  def destroy?
    record.user_role(user) == 'admin'
  end

  def show?
    record.user_role(user) == 'admin'
  end
end
