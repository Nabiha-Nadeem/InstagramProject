# frozen_string_literal: true

# app/models/user.rb
# controller to manage users
class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    redirect_to new_user_session_path unless user_signed_in?
    @users_with_story = User.with_stories
    @story = Story.new
    @posts = Post.all.includes(:photos)
    @post_new = Post.new
  end

  def follow_user
    user_id = params[:format]
    @follow = current_user.follows.create(following_id: user_id)
    if @follow.save
      redirect_to user_path(user_id)
      (flash[:notice] = 'Followed!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
      redirect_to users_path
    end
  end

  def unfollow_user
    user_id = params[:format]
    follow_id = Follow.find_by(user_id: current_user.id, following_id: user_id )
    # @unfollow = current_user.follows.delete(follow_id)
    if current_user.follows.delete(follow_id)
      redirect_to user_path(user_id)
      (flash[:notice] = 'Unfollowed!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
      redirect_to users_path
    end
  end

end
