class TicketsController < ApplicationController
  before_action :set_event
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tickets = @event.tickets
  end

  def show
  end

  def new
    @ticket = @event.tickets.build
    render turbo_stream: turbo_stream.update("modal", partial: "tickets/modal", locals: { event: @event, ticket: @ticket })
  end

  def create
    @ticket = @event.tickets.build(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.append("tickets", partial: "events/show/ticket", locals: { tickets: @event.tickets }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { message: "Билет успешно создан", type: "success" }),
            turbo_stream.update("modal", "")
          ]
        }
        format.html { redirect_to @event, notice: 'Билет успешно создан.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("modal", partial: "tickets/modal", locals: { event: @event, ticket: @ticket })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render turbo_stream: turbo_stream.update("modal", partial: "tickets/modal", locals: { event: @event, ticket: @ticket })
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.replace(@ticket, partial: "events/show/ticket", locals: { tickets: @event.tickets }),
            turbo_stream.update("flash", partial: "shared/flash", locals: { message: "Билет успешно обновлен", type: "success" }),
            turbo_stream.update("modal", "")
          ]
        }
        format.html { redirect_to @event, notice: 'Билет успешно обновлен.' }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("modal", partial: "tickets/modal", locals: { event: @event, ticket: @ticket })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.remove(@ticket),
          turbo_stream.update("flash", partial: "shared/flash", locals: { message: "Билет успешно удален", type: "success" })
        ]
      }
      format.html { redirect_to @event, notice: 'Билет успешно удален.' }
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
    params.require(:ticket).permit(:ticket_type, :price, :currency, payment_method: [])
  end

  def authorize_user
    unless current_user.id == @event.user_id || current_user.admin? || current_user.moderator?
      redirect_to @event, alert: 'У вас нет прав для выполнения этого действия.'
    end
  end
end