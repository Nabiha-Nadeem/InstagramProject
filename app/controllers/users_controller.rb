# frozen_string_literal: true

# app/models/user.rb
# controller to manage users
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
