class ApplicationController < ActionController::Base
  skip_before_action :authenticate_user!, raise: false

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
