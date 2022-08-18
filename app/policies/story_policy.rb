# frozen_string_literal: true

# policy for stories
class StoryPolicy < ApplicationPolicy
  def destroy?
    record.user == user
  end
end
