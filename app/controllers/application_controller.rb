class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_have_access
  
  skip_before_action :authenticate_user!, raise: false
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  private
  def user_not_have_access
    flash[:alert] = "У вас нет прав на это действие"
    redirect_to(request.referrer || root_path)
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
