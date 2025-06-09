class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_venue, only: %i[show edit update destroy]
  
  def index
    @venues = Venue.includes(:reviews, :information, :service, :facility, :rental_info)

    @venues = @venues.where('venue_type LIKE ?', "%#{params[:venue_type]}%") if params[:venue_type].present?
    @venues = @venues.where('max_participants LIKE ?', "%#{params[:max_participants]}%") if params[:max_participants].present?
    @venues = @venues.where('address LIKE ?', "%#{params[:address]}%") if params[:address].present?

    if params[:search].present?
      @venues = @venues.where('name LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    authorize @venue

    @reviewable = @venue
    @reviews = @reviewable.reviews.includes(user: :profile).order(created_at: :desc)
  end

  def new
    @venue = current_user.venues.build
    build_associations

    authorize @venue
  end

  def create
    @venue = current_user.venues.build(venue_params)
    @venue.venue_type = params[:venue][:venue_type].split(',').map(&:strip)
    authorize @venue

    if @venue.save
      if params[:venue][:media_files].present?
        params[:venue][:media_files].each do |file|
          next unless file.is_a?(ActionDispatch::Http::UploadedFile)
          
          media_file = @venue.media_files.build
          media_file.file = file
          media_file.file_type = file.content_type.start_with?('image/') ? 'image' : 'video'
          media_file.content_type = file.content_type
          media_file.file_size = file.size
          media_file.save
        end
      end

      redirect_to @venue, notice: 'Площадка успешно создана.'
    else
      flash.now[:alert] = 'Не удалось создать площадку. Проверьте введенные данные.'
      render :new
    end
  end

  def edit
    @selected_tags = @venue.venue_type || []
    build_associations
    authorize @venue

  end

  def update
    @venue.venue_type = params[:venue][:venue_type].split(',').map(&:strip)
    authorize @venue

    if @venue.update(venue_params)
      if params[:venue][:media_files].present?
        params[:venue][:media_files].each do |file|
          next unless file.is_a?(ActionDispatch::Http::UploadedFile)
          
          media_file = @venue.media_files.build
          media_file.file = file
          media_file.file_type = file.content_type.start_with?('image/') ? 'image' : 'video'
          media_file.content_type = file.content_type
          media_file.file_size = file.size
          media_file.save
        end
      end

      redirect_to @venue, notice: 'Площадка была успешно обновлена.'
    else
      flash.now[:alert] = 'Не удалось обновить площадку. Проверьте введенные данные.'
      render :edit
    end
  end

  def destroy
    authorize @venue

    if @venue.destroy
      redirect_to venues_path, notice: 'Площадка успешно удалена.'
    else
      redirect_back fallback_location: venues_path, alert: 'Не удалось удалить площадку.'
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to venues_path, alert: 'Площадка не найдена или у вас нет прав для ее просмотра.'
  end

  def build_associations
    @venue.build_information unless @venue.information
    @venue.build_facility unless @venue.facility
    @venue.build_service unless @venue.service
    @venue.build_rental_info unless @venue.rental_info
    @venue.media_files.build if @venue.media_files.empty?
  end

  def venue_params
    params.require(:venue).permit(
      :name, :description, :address, :district, :phone, :email, :website,
      :area, :max_participants, :details, venue_type: [],
      facility_attributes: [:wifi, :air_conditioning, :audio_visual_equipment, :parking, :disabled_access, :kitchen, :toilets_count, :other_facilities, :_destroy],
      information_attributes: [:document, :description, :calendar, :smoking_allowed, :alcohol_allowed, :noise_restrictions, :event_types, :restrictions, :_destroy],
      service_attributes: [:technical_equipment, :furniture, :decoration, :cleaning_after_event, :security, :other_services, :_destroy],
      rental_info_attributes: [:price, :discounts, :min_rental_duration_hours, :payment_terms, :working_hours_start, :working_hours_end, :rules, :disclaimer, :_destroy],
      media_files_attributes: [:id, :file, :title, :description, :_destroy]
    )
  end
end
