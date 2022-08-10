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

  def search
    @users = User.search_like_any([:fullname], params[:search])
    render template: 'users/show-results', locals: { users: @users }
  end
end
