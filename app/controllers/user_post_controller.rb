class UserPostController < ApplicationController
  
  def create
   @post =  UserPost.new(params[:user_post])
   respond_to do |format|
     if @post.save()
       format.json { render json: @post, status: :created }
     end
   end
  end
end
