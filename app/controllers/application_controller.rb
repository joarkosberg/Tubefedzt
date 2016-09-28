class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Redirect to votepage after login
  def after_sign_in_path_for(resource)
    songs_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # Handle authorization exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
  end
end
