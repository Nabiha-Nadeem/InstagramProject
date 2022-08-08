# frozen_string_literal: true

# to handle likes
class LikesController < ApplicationController
  before_action :find_post
  def create
    if already_liked?
      flash[:alert] = 'You can like only once!'
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
      params[:post_id]).exists?
  end
end
