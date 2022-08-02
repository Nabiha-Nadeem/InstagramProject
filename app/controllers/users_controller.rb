# frozen_string_literal: true

# app/models/user.rb
# controller to manage users
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
    @stories = Story.all.includes(:photos)
    @story = Story.new
    @posts = Post.all.includes(:photos)
    @post = Post.new
  end

end
