class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create, :show, :edit, :reviews]

  def show
    @profile = @user.profile || @user.build_profile
    authorize @profile

    render :show
  end

  def new
    if @user.profile.present?
      redirect_to user_profile_path(@user), notice: 'У вас уже есть профиль.'
    else
      @profile = @user.build_profile
    end
  end

  def create
    @profile = @user.build_profile(profile_params)

    if @profile.valid? 
      @profile.save!
      redirect_to user_profile_path(@user), notice: 'Профиль был создан.'
    else
      flash.now[:alert] = 'Ошибка создания профиля, проверьте введенные данные'
      render :new
    end
  end

  def edit
    @profile = current_user.profile
    authorize @profile
  end

  def update
    @profile = current_user.profile
    authorize @profile
    if params[:cover_color]
      if @profile.update_cover_color(params[:cover_color])
        redirect_to user_profile_path(current_user), notice: "Цвет обложки успешно обновлен"
      else
        redirect_to user_profile_path(current_user), alert: "Ошибка: недопустимый формат цвета"
      end
    elsif @profile.update(profile_params)
      respond_to do |format|
        format.html { redirect_to user_profile_path(current_user), notice: "Ваш профиль был успешно обновлен"
      }
      format.turbo_stream
      end
    else
      @user = current_user
      flash.now[:alert] = 'Ошибка при обновлении профиля.'
      render :edit
    end
  end

  def reviews
    @profile = @user.profile || @user.build_profile
    @reviewable = @profile
    @reviews = @profile.reviews.includes(user: :profile).order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id]) || current_user
    redirect_to root_path, alert: "Пользователь не найден." unless @user
  end

  def profile_params
    params.require(:profile).permit(
      :first_name, :last_name, :middle_name, :birthday_date, :phone, :city, :gender, :options, :avatar, :cover_color
    )
  end
end
