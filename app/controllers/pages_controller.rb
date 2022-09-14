# frozen_string_literal: true

# to handle pages
class PagesController < ApplicationController
  include Roles
  before_action :authenticate_user!
  before_action :find_page, only: %i[edit update destroy show]

  def create
    @page = Page.new(page_params)
    if @page.save
      save_role(current_user.id, @page.id, 'admin')
    else
      flash[:alert] = @page.errors.full_messages
    end
    redirect_to user_path(current_user.id)
  end

  def new
    @page = Page.new
  end

  def edit
    authorize @page
  end

  def update
    authorize @page
    if @page.update(page_params)
      flash[:notice] = 'Page updated!'
    else
      flash[:alert] = 'Error occurred while updating the page!'
    end
    redirect_to user_path(@page)
  end

  def destroy
    authorize @page
    if @page.destroy
      flash[:notice] = 'Page deleted!'
    else
      flash[:alert] = 'Error occurred while deleting the page!'
    end
    redirect_to users_path
  end

  def show
    authorize @page
  end

  private

  def find_page
    @page = Page.find_by(id: params[:id])

    return if @page

    flash[:alert] = 'Page not found!'
    redirect_to root_path
  end

  def page_params
    params.require(:page).permit(:bio, :fullname)
  end
end
