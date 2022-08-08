# frozen_string_literal: true

# controller to manage comments
class CommentsController < ApplicationController
  before_action :find_post, only: %i[edit create destroy update]
  before_action :find_comment, only: %i[edit destroy update]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    redirect_to @post
    if @comment.save
      flash[:notice] = 'Commented!'
    else
      flash[:alert] = 'Error occurred while adding the comment!'
    end
  end

  def edit; end

  def update
    redirect_to @post
    if @comment.user_id == current_user.id
      if @comment.update(comment_params)
        flash[:notice] = 'Comment updated!'
      else
        flash[:alert] = 'Error occurred while updating the comment!'
      end
    else
      flash[:alert] = "You can't update someone else's comment!"
    end
  end

  def destroy
    redirect_to @post
    if @comment.user_id == current_user.id
      if @comment.destroy
        flash[:notice] = 'Comment deleted!'
      else
        flash[:alert] = 'Error occurred while deleting the comment!'
      end
    else
      flash[:alert] = "You can't delete someone else's comment!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find(params[:post_id])
    return if @post

    flash[:danger] = 'Post not found!'
    redirect_to root_path
  end

  def find_comment
    @comment = Comment.find(params[:id])
    return if @comment

    flash[:danger] = 'Comment not found!'
    redirect_to root_path
  end
end
