class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user
  
  helper_method :current_user
  
  private
  
  def current_user
    session[:current_user_id]
  end
end
