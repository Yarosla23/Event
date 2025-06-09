class MediaFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_file
  before_action :authorize_user

  def destroy
    if @media_file.destroy
      redirect_back(fallback_location: root_path, notice: 'Файл успешно удален')
    else
      redirect_back(fallback_location: root_path, alert: 'Не удалось удалить файл')
    end
  end

  private

  def set_media_file
    @media_file = MediaFile.find(params[:id])
  end

  def authorize_user
    unless current_user == @media_file.attachable.user || current_user.admin? || current_user.moderator?
      redirect_to root_path, alert: 'У вас нет прав для выполнения этого действия'
    end
  end
end 