class HomeController < ApplicationController
#  before_filter :authenticate_user!
  layout 'static'
  def index
    if user_signed_in? 
      
    end
  else 
    @user = User.new
  
    
  end
  
  def signup
    @user = User.new
  end
end
