# frozen_string_literal: true

# controller to manage subscriptions
class SubscriptionsController < ApplicationController
  before_action :find_user, only: :index

  def new; end

  def create
    price_id = 'price_1LhZcMKKYhkmO3hZGQ47vrKJ'
    user_id = params[:id]
    session = Stripe::Checkout::Session.create({
                                                 success_url: subscriptions_url(id: user_id), cancel_url: root_url,
                                                 payment_method_types: ['card'], mode: 'subscription',
                                                 line_items: [{ quantity: 1, price: price_id }]
                                               })
    redirect_to session[:url]
  end

  def index
    @user.subscribed = true
    flash[:notice] = 'Saved' if @user.save
    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:alert] = 'User not found!'
    redirect_to root_path
  end
end
