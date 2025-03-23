class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = EventFilter.new(params).filter
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
