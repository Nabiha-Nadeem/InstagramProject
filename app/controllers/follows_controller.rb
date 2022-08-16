# frozen_string_literal: true

# controller to manage follows
class FollowsController < ApplicationController
  before_action :authenticate_user!
  def follow_user
    user_id = params[:id]
    @follow = current_user.follows.create(following_id: params[:id])
    if @follow.save
      redirect_to user_path(user_id)
      (flash[:notice] = 'Followed!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
      redirect_to users_path
    end
  end

  def unfollow_user
    user_id = params[:id]
    follow_id = Follow.find_by(user_id: current_user.id, following_id: user_id)
    if current_user.follows.delete(follow_id)
      redirect_to user_path(user_id)
      (flash[:notice] = 'Unfollowed!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
      redirect_to users_path
    end
  end
end
