# frozen_string_literal: true

# to handle pages
class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  include Roles
  before_action :find_rel, only: :destroy

  def create
    @account = Account.find_by email: params[:relation][:email]
    @page = params[:relation][:id]
    if @account
      @given_role = params[:relation][:role]
      create_role(@account, @page, @given_role)
    else
      flash[:alert] = 'Invalid email!'
      redirect_to page_path(@page)
    end
  end

  def destroy
    if @role.destroy
      flash[:notice] = 'Removed role!'
    else
      flash[:alert] = 'Error occurred while removing the role!'
    end
    redirect_to users_path
  end

  private

  def create_role(account, page, given_role)
    if role_exists?(account, page)
      flash[:alert] = 'Role already exists!'
    else
      save_role(account.id, page, given_role)
    end
    redirect_to page_path(@page)
  end

  def find_rel
    @page = Page.find_by(id: params[:id])
    if @page.accounts.count > 1
      @role = UserPageRelationship.find_by(page_id: params[:id], user_id: params[:account])
      return if @role

      flash[:alert] = 'Relation not found!'
    else
      flash[:alert] = "Can't delete the last associated user. Please directly delete the page!"
    end
    redirect_to root_path
  end
end
