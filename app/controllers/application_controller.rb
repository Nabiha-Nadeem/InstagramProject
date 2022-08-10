# frozen_string_literal: true

# to control the application flow
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fullname avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname avatar bio is_private])
  end

end
