# frozen_string_literal: true

# to control posts
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy update]

  def create
    @post = current_user.posts.build(post_params)
    if params[:images].count < 11
      save_photos
    else
      redirect_to users_path
      (flash[:alert] = 'Please add less than 10 images!')
    end
  end

  def destroy
    redirect_to users_path
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = 'Post deleted!'
      else
        flash[:alert] = 'Error occurred while deleting the post!'
      end
    else
      flash[:alert] = "You can't delete someone else's post!"
    end
  end

  def update
    redirect_to users_path
    if @post.user == current_user
      if @post.update(post_params)
        flash[:notice] = 'Post updated!'
      else
        flash[:alert] = 'Error occurred while updating the post!'
      end
    else
      flash[:alert] = "You can't update someone else's post!"
    end
  end

  def show; end

  private

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post

    flash[:alert] = 'Post not found!'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit :content
  end

  def save_photos
    if @post.save
      params[:images]&.each do |img|
        @post.photos.create(image: img)
      end
      redirect_to users_path
      (flash[:notice] = 'Saved!')
    else
      redirect_to users_path
      (flash[:alert] = 'An unexpected error occurred!')
    end
  end
end
