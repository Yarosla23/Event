class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @q = Event.includes(:participant, :tickets).ransack(params[:q])
    @events = @q.result(distinct: true)
    
    # Применяем поиск по тексту, если есть параметр search
    if params[:search].present?
      @events = @events.search_by_all(params[:search])
    end

    # Фильтрация по тегам
    if params[:tags].present?
      @events = @events.search_by_tags(params[:tags])
    end

    # Фильтрация по дате
    if params[:start_time].present?
      @events = @events.where('start_time >= ?', params[:start_time])
    end

    # Фильтрация по типу участников
    if params[:participant_type].present?
      @events = @events.joins(:participant).where(participants: { participant_type: params[:participant_type] })
    end

    # Фильтрация по приватности
    if params[:is_private].present?
      @events = @events.joins(:participant).where(participants: { is_private: params[:is_private] })
    end

    # Фильтрация по платности
    if params[:is_paid].present?
      @events = @events.joins(:participant).where(participants: { is_paid: params[:is_paid] })
    end

    @events = @events.order(created_at: :desc)
  end

  def my_events
    @events = current_user.events.includes(:participant, :logistic, :tickets, :event_rule)
    render :index
  end

  def show
    authorize @event

    @reviewable = @event 
    @reviews = @reviewable.reviews.includes(user: :profile).order(created_at: :desc)
  end

  def new
    @event = current_user.events.build
    build_associations
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    @event.tags = params[:event][:tags].split(',').map(&:strip)
    authorize @event
    if @event.save
      if params[:event][:media_files].present?
        params[:event][:media_files].each do |file|
          next unless file.is_a?(ActionDispatch::Http::UploadedFile)
          
          media_file = @event.media_files.build
          media_file.file = file
          media_file.file_type = file.content_type.start_with?('image/') ? 'image' : 'video'
          media_file.content_type = file.content_type
          media_file.file_size = file.size
          media_file.save
        end
      end

      redirect_to @event, notice: 'Мероприятие успешно создано.'
    else
      flash.now[:alert] = 'Не удалось создать мероприятие. Проверьте введенные данные.'
      render :new
    end
  end

  def edit
    @selected_tags = @event.tags || []
    build_associations
    authorize @event
  end

  def update
    @event.tags = params[:event][:tags].present? ? params[:event][:tags].split(',').map(&:strip) : []
    authorize @event

    if @event.update(event_params)
      if params[:event][:media_files].present?
        params[:event][:media_files].each do |file|
          next unless file.is_a?(ActionDispatch::Http::UploadedFile)
          
          media_file = @event.media_files.build
          media_file.file = file
          media_file.file_type = file.content_type.start_with?('image/') ? 'image' : 'video'
          media_file.content_type = file.content_type
          media_file.file_size = file.size
          media_file.save
        end
      end

      redirect_to @event, notice: 'Мероприятие было успешно обновлено.'
    else
      flash.now[:alert] = 'Не удалось обновить мероприятие. Проверьте введенные данные.'
      render :edit
    end
  end

  def destroy
    authorize @event
    if @event.destroy
      redirect_to events_path, notice: "Событие успешно удалено."
    else
      redirect_back fallback_location: events_path, alert: "Не удалось удалить событие."
    end
  end

  def delete_media_file
    @event = Event.find(params[:id])
    @media_file = @event.media_files.find(params[:media_file_id])
    
    if @media_file.destroy
      respond_to do |format|
        format.html { redirect_to @event, notice: 'Медиафайл успешно удален.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @event, alert: 'Не удалось удалить медиафайл.' }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: 'Событие не найдено или у вас нет прав для его просмотра.'
  end

  def build_associations
    @event.build_participant unless @event.participant
    @event.build_logistic unless @event.logistic
    @event.tickets.build if @event.tickets.empty?
    @event.build_event_rule unless @event.event_rule
  end

  def event_params
    params.require(:event).permit(
      :name, :description, :event_type, :start_time, :end_time, :location, :location_link, :event_format,
      event_rule_attributes: [:rules, :consent, :_destroy],
      participant_attributes: [:min_participants, :max_participants, :participant_type, :is_private, :is_paid, :_destroy],
      logistic_attributes: [:organizers, :contact_info, :technical_requirements, :special_instructions, :_destroy],
      tickets_attributes: [:ticket_type, :price, :currency, :discount_code, :_destroy, payment_method: []],
      media_files_attributes: [:id, :file, :title, :description, :_destroy]
    )
  end

  def authorize_user
    unless current_user == @event.user || current_user.admin? || current_user.moderator?
      redirect_to events_path, alert: 'У вас нет прав для выполнения этого действия.'
    end
  end
end
