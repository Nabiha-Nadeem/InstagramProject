# frozen_string_literal: true

# to handle likes
class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @parent, @id, @name = parent
    if @parent
      create_helper
    else
      flash[:alert] = 'Resource to like not found!'
      redirect_to users_path
    end
  end

  private

  def create_helper
    if already_liked?(@parent, @name)
      flash[:alert] = 'You can like only once!'
      redirect_to post_path(@id)
    else
      @like = @parent.likes.create(user_id: current_user.id)
      respond_to :js
    end
  end

  def parent
    if params[:post_id]
      parent_element = Post.find_by(id: params[:post_id])
      return [parent_element, parent_element.id, 'Post'] if parent_element
    elsif params[:comment_id]
      parent_element = Comment.find_by(id: params[:comment_id])
      return [parent_element, parent_element.post_id, 'Comment'] if parent_element
    end
  end

  def already_liked?(parent, name)
    Like.exists?(user_id: current_user.id, likeable_id: parent.id, likeable_type: name)
  end
end
