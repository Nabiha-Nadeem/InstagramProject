# frozen_string_literal: true

# app/models/user.rb
# controller to manage stories
class StoriesController < ApplicationController
  before_action :authenticate_user!

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
    @user = User.find(params[:id])
    @stories = @user.stories
    @oldest_story = @stories.order('created_at asc').first
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
end
