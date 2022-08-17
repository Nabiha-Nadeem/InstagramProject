# frozen_string_literal: true

# controller to manage comments
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[edit create destroy update]
  before_action :find_comment, only: %i[edit destroy update]
  after_action :verify_authorized, only: %i[edit destroy update]

  def create
    @comment = @post.comments.create(comment_params.merge({ user_id: current_user.id }))
    if @comment.body.blank?
      flash[:alert] = 'Cannot add empty comment!'
      redirect_to @post
    elsif @comment.save
      respond_to :js
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    redirect_to @post
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated!'
    else
      flash[:alert] = 'Error occurred while updating the comment!'
    end
  end

  def destroy
    authorize @comment
    respond_to :js if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
    return if @post

    flash[:alert] = 'Post not found!'
    redirect_to root_path
  end

  def find_comment
    @comment = Comment.find_by(id: params[:id])
    return if @comment

    flash[:alert] = 'Comment not found!'
    redirect_to root_path
  end

  def save_comment
    if @comment.save
      flash[:notice] = 'Commented!'
    else
      flash[:alert] = 'Error occurred while adding the comment!'
    end
    redirect_to @post
  end
end
