class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.includes(:participant, :logistic, :tickets)
  end

  def show
  end

  def new
    @event = Event.new
    @event.build_participant unless @event.participant
    @event.build_logistic unless @event.logistic
    @event.tickets.build if @event.tickets.empty?
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Мероприятие успешно создано.'
    else
      flash.now[:alert] = 'Не удалось создать мероприятие. Проверьте введенные данные.'
      render :new
    end
  end

  def edit
    @event.build_participant unless @event.participant
    @event.build_logistic unless @event.logistic
    @event.tickets.build if @event.tickets.empty?
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Мероприятие было успешно обновлено.'
    else
      flash.now[:alert] = 'Не удалось обновить мероприятие. Проверьте введенные данные.'
      render :edit
    end
  end


  def destroy
    binding.irb
    if @event.destroy
      flash[:notice] = "Событие успешно удалено."
      redirect_to events_path # Или другая страница
    else
      flash[:alert] = "Не удалось удалить событие."
      redirect_back fallback_location: events_path
    end
  end
  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :description, :event_type, :start_time, :end_time, :location, :location_link, :event_format,
      participant_attributes: [:id, :min_participants, :max_participants, :participant_type, :is_private, :is_paid, :_destroy],
      tickets_attributes: [:id, :ticket_type, :price, :currency, :payment_method, :discount_code, :_destroy],
      logistic_attributes: [:id, :organizers, :contact_info, :technical_requirements, :special_instructions, :_destroy]
    )
  end
end
