class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = Event.includes(:participant, :logistic, :tickets, :event_rule)
    @events = @events.where('start_time >= ?', params[:start_time]) if params[:start_time].present?
    @events = @events.where('location LIKE ?', "%#{params[:location]}%") if params[:location].present?

    if params[:tags].present?
      tags = params[:tags].split(',').map(&:strip)
      @events = @events.where('tags @> ARRAY[?]::text[]', tags)
    end
    if params[:search].present?
      @events = @events.where('name LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end
    if params[:participant_type].present?
      @events = @events.joins(:participant).where(participant: { participant_type: params[:participant_type] })
    end
  
    if params[:is_private].present?
      is_private = ActiveRecord::Type::Boolean.new.cast(params[:is_private])
      @events = @events.joins(:participant).where(participant: { is_private: is_private })
    end
  
    if params[:is_paid].present?
      is_paid = ActiveRecord::Type::Boolean.new.cast(params[:is_paid])
      @events = @events.joins(:participant).where(participant: { is_paid: is_paid })
    end
    @events = @events.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def my_events
    @events = current_user.events.includes(:participant, :logistic, :tickets, :event_rule)
    render :index
  end

  def show
    authorize @event
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
    @event.tags = params[:event][:tags].split(',').map(&:strip)
    authorize @event
    if @event.update(event_params)
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
      :name, :description, :event_type, :start_time, :end_time, :location, :location_link, :event_format, tags: [], event_photos_attributes: [:id, :photo, :_destroy],
      event_rule_attributes: [:rules, :consent, :_destroy],
      participant_attributes: [:min_participants, :max_participants, :participant_type, :is_private, :is_paid, :_destroy],
      logistic_attributes: [:organizers, :contact_info, :technical_requirements, :special_instructions, :_destroy],
      tickets_attributes: [:ticket_type, :price, :currency, :discount_code, :_destroy, payment_method: []]
    )
  end
end
