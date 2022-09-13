# frozen_string_literal: true

# app/models/user.rb
# controller to manage users
class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_user, only: :show

  def show
    @posts = @user.posts
    @post_new = Post.new
    @story = Story.new
    @stories = @user.stories
  end

  def index
    redirect_to new_user_session_path unless user_signed_in?
    @users_with_story = User.with_stories
    @story = Story.new
    @posts = Post.all.includes(:photos)
    @post_new = Post.new
  end

  def search
    @users = User.search_like_any([:fullname], params[:search])
    render template: 'users/show-results', locals: { users: @users }
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:alert] = 'User not found!'
    redirect_to root_path
  end
end
