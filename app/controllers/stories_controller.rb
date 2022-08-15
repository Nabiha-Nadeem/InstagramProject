# frozen_string_literal: true

# app/models/user.rb
# controller to manage stories
class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: :show

  def create
    @story = current_user.stories.build
    if params[:image]
      save_story
    else
      redirect_to users_path
      (flash[:alert] = 'Please add single image!')
    end
  end

  def show
    redirect_to root_path unless current_user.following.include?(@user) || (@user == current_user)
    @stories = @user.stories
    @oldest_story = @stories.order('created_at asc').first
  end

  def destroy
    @story = Story.find_by id: params[:id]
    redirect_to users_path
    if @story.user == current_user
      flash[:notice] = 'Story deleted!' if @story.destroy
      flash[:alert] = 'Error occurred while deleting the story!' unless @story.destroy
    else
      flash[:alert] = "You can't delete someone else's story!"
    end
  end

  private

  def save_story
    if @story.save
      @story.photos.create(image: params[:image])
      redirect_to users_path
      (flash[:notice] = 'Saved!')
    else
      (flash[:alert] = 'An unexpected error occurred!')
      redirect_to users_path
    end
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:alert] = 'User not found!'
    redirect_to root_path
  end
end
