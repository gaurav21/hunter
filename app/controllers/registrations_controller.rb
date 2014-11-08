class RegistrationsController < Devise::RegistrationsController
  protected
#    before_action  :authenticate_user!

    def after_sign_up_path_for(resource)
      '/an/example/path'
    end
  
    def after_sign_in_path_for(resource)
      @current_user = User.find_by_token params[:auth_token]
#     if current_user.admin?     
#      stored_location_for(resource) || admin_path     
#    else       
       stored_location_for(resource) || dashboard_path(current_user.id)      
#     end       

  end
end
