# frozen_string_literal: true

# policy for Posts
class PostPolicy < ApplicationPolicy

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
