class ReviewsController < ApplicationController
  before_action :set_venue
  before_action :authenticate_user!

  def create
    @review = @venue.reviews.new(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to @venue, notice: 'Ваш отзыв успешно добавлен!'
    else
      redirect_to @venue, alert: 'Ошибка при добавлении отзыва.'
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
