class ProfilesController < ApplicationController
  before_action :set_user, only: [:new, :create, :show, :edit]

  before_action :authenticate_user!

  def show
    @user = current_user
    @profile = @user.profile || @user.build_profile
    @days_registered = @user.days_registered

    render :show
  end


  def new
    @profile = @user.build_profile
  end

  def create
    @profile = @user.build_profile(profile_params)

    if @profile.save
      redirect_to user_profile_path(@user), notice: 'Профиль был создан.'
    else
      render :new, alert: 'Ошибочка.'
    end
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile

    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: 'Профиль был обновлен.'
    else
      render :edit
    end
  end


  private

  def set_user
    @user = User.find_by(id: params[:user_id]) || current_user
    redirect_to root_path, alert: "Пользователь не найден." unless @user
  end

  def profile_params
    params.require(:profile).permit(:avatar, :username, :birthday_date, :options)
  end
end
