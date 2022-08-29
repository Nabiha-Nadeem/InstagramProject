# frozen_string_literal: true

# to control posts
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy update edit]
  after_action :verify_authorized, only: %i[edit destroy update]

  def create
    @post = current_user.posts.build(post_params)
    if params[:images] && params[:images].count < 11
      save_photos
    else
      redirect_to users_path
      flash[:alert] = 'Please add images (at max 10)!'
    end
  end

  def edit
    authorize @post
  end

  def destroy
    authorize @post
    if @post.destroy
      flash[:notice] = 'Post deleted!'
    else
      flash[:alert] = 'Error occurred while deleting the post!'
    end
    redirect_to users_path
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:notice] = 'Post updated!'
    else
      flash[:alert] = 'Error occurred while updating the post!'
    end
    redirect_to users_path
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
      save_photos_safely
    else
      (flash[:alert] = 'An unexpected error occurred!')
      redirect_to users_path
    end
  end

  def save_photos_safely
    params[:images]&.each do |img|
      @post.photos.create(image: img)
    end
    (flash[:notice] = 'Saved!')
    redirect_to users_path
  rescue StandardError
    redirect_to users_path
    (flash[:alert] = 'Please add an image')
  end
end
