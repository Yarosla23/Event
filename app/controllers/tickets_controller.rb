class TicketsController < ApplicationController
  before_action :set_event
  before_action :authenticate_user!
  before_action :set_ticket, only: [:destroy]

  def create
    @ticket = @event.tickets.new(ticket_params)
    @ticket.user = current_user
    
    if @ticket.save
      redirect_to @event, notice: 'Билет успешно приобретен!'
    else
      redirect_to @event, alert: 'Не удалось приобрести билет'
    end
  end

  def destroy
    if @ticket.user == current_user
      @ticket.destroy
      redirect_to @event, notice: 'Билет успешно отменен.'
    else
      redirect_to @event, alert: 'Вы не можете отменить этот билет.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_ticket
    @ticket = @event.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:price, :event_date, :seat)
  end
end