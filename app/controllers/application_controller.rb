class ApplicationController < ActionController::Base
    include ApplicationHelper
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    def autherize?(obj)    
        unless allowed_to?(current_user,obj)
          flash[:alert] = 'You are not autherized to access this page..!!'
          redirect_to root_url and return
      end
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    end
end
