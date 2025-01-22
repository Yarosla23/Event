class VenuesController < ApplicationController
  before_action :set_venue, only: %i[show edit update destroy]

  def index
    @venues = Venue.includes(:reviews, :amenities)
    # @venues = Venue.includes(:reviews, :amenities, :event_types, :prices, :policies)

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
  end

  def new
    @venue = Venue.new
    build_associations
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to @venue, notice: 'Площадка успешно создана.'
    else
      flash.now[:alert] = 'Не удалось создать площадку. Проверьте введенные данные.'
      render :new
    end
  end

  def edit
    build_associations
  end

  def update
    if @venue.update(venue_params)
      redirect_to @venue, notice: 'Площадка была успешно обновлена.'
    else
      flash.now[:alert] = 'Не удалось обновить площадку. Проверьте введенные данные.'
      render :edit
    end
  end

  def destroy
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
    @venue.build_price unless @venue.price
    @venue.build_policy unless @venue.policy
    @venue.event_types.build if @venue.event_types.empty?
  end

  def venue_params
    params.require(:venue).permit(
      :name, :venue_type, :description, :address, :district, :phone, :email, :website,
      :area, :max_participants, :details,
      price_attributes: [:id, :amount, :currency, :min_duration, :_destroy],
      policy_attributes: [:id, :smoking_allowed, :alcohol_allowed, :noise_restrictions, :_destroy],
      event_types_attributes: [:id, :name, :_destroy]
    )
  end
end
