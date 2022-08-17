# frozen_string_literal: true

# to handle requests
class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_request, only: %i[update]

  def create
    @request = current_user.requests.create(following_id: params[:following_id])
    if @request.save
      flash[:notice] = 'Follow request sent!'
    else
      flash[:alert] = "Error. Couldn't send follow request"
    end
    redirect_to user_path(params[:following_id])
  end

  def index
    @requests = Request.pending_requests(current_user)
  end

  def update
    @request.update(is_accepted: params[:is_accepted])
    if @request.is_accepted
      create_follow(@request.sender, @request.following_id)
      flash[:notice] = 'Request accepted!'
    else
      flash[:notice] = 'Request declined!'
    end
    remove_request(@request.id)
    redirect_to users_path
  end

  def remove_request(request_id)
    flash[:alert] = 'An unexpected error occurred!' unless Request.delete(request_id)
  end

  def remove_follow_request
    user_id = params[:id]
    request_id = Request.find_by(user_id: current_user.id, following_id: user_id)
    if current_user.requests.delete(request_id)
      flash[:notice] = 'Request removed!'
    else
      flash[:alert] = 'An unexpected error occurred!'
    end
    redirect_to user_path(user_id)
  end

  private

  def create_follow(user, user_id)
    @follow = user.follows.create(following_id: user_id)
    return if @follow.save

    raise StandardError "Couldn't accept follower!"
  rescue StandardError
    flash[:alert] = 'Follower could not be added!'
  end

  def find_request
    @request = Request.find_by(id: params[:id])
    return if @request

    flash[:alert] = 'Request not found!'
    redirect_to root_path
  end
end
