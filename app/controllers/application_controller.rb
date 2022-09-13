# frozen_string_literal: true

# to control the application flow
class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Not authorized to perform this action!'
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fullname avatar is_private type])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname avatar bio is_private])
  end
end
