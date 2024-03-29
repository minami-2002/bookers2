class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user) # ログインした直後は、ユーザーの詳細ページに遷移
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
