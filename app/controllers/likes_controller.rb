# frozen_string_literal: true

# to handle likes
class LikesController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_post
  def create
    @parent, @id, @name = parent
    if already_liked?(@parent, @name)
      flash[:alert] = 'You can like only once!'
      redirect_to post_path(@id)
    else
      #@post.likes.create(user_id: current_user.id)
      @like = @parent.likes.create(user_id: current_user.id)
      respond_to :js
    end
  end

  private

  # def find_post
  #   @post = Post.find_by(id: params[:post_id])
  #   return if @post

  #   flash[:alert] = 'Post not found!'
  #   redirect_to root_path
  # end
  def parent
    if params[:post_id]
      parent_elem = Post.find params[:post_id]
      id = parent_elem.id
      name = 'Post'
    elsif params[:comment_id]
      parent_elem = Comment.find params[:comment_id]
      id = parent_elem.post_id
      name = 'Comment'
    end
    [parent_elem, id, name]
  end

  def already_liked?(parent, name)
    Like.exists?(user_id: current_user.id, likeable_id: parent.id, likeable_type: name)
  end
end
