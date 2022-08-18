# frozen_string_literal: true

# to handle likes
class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  def create
    if already_liked?
      flash[:alert] = 'You can like only once!'
      redirect_to post_path(@post)
    else
      @post.likes.create(user_id: current_user.id)
      respond_to :js
    end
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])
    return if @post

    flash[:alert] = 'Post not found!'
    redirect_to root_path
  end

  def already_liked?
    Like.exists?(user_id: current_user.id, post_id: params[:post_id])
  end
end
