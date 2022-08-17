# frozen_string_literal: true

# policy for comments
class CommentPolicy < ApplicationPolicy

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user or record.post.user == user
  end
end
