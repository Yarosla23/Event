class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @days_registered = current_user.days_registered
  end
end
