class ReviewsController < ApplicationController
  before_action :set_venue
  before_action :authenticate_user!
  before_action :set_review, only: [:destroy]

  def create
    @review = @venue.reviews.new(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to @venue, notice: 'Ваш отзыв успешно добавлен!'
    else
      redirect_to @venue, alert: 'Выберите оценку и напишите отзыв'
    end
  end

  def destroy
    if @review.user == current_user
      @review.destroy
      redirect_to @venue, notice: 'Ваш отзыв был удален.'
    else
      redirect_to @venue, alert: 'Вы не можете удалить этот отзыв.'
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def set_review
    @review = @venue.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
