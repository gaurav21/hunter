class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate_user
    
  end
  def after_sign_in_path_for(resource)
    post_path
  end
  
end
