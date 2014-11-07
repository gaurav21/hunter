class HomeController < ApplicationController
  def index
    @user = User.new
    render :layout => 'static'
  end
end
