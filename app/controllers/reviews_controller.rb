class ReviewsController < ApplicationController
  before_action :set_reviewable
  before_action :authenticate_user!
  before_action :set_review, only: [:destroy]

  def create
    @review = @reviewable.reviews.new(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to @reviewable, notice: 'Ваш отзыв успешно добавлен!'
    else
      redirect_to @reviewable, alert: 'Выберите оценку и напишите отзыв'
    end
  end

  def destroy
    if @review.user == current_user
      @review.destroy
      redirect_to @reviewable, notice: 'Ваш отзыв был удален.'
    else
      redirect_to @reviewable, alert: 'Вы не можете удалить этот отзыв.'
    end
  end

  private

  def set_reviewable
    if params[:venue_id]
      @reviewable = Venue.find(params[:venue_id])
    elsif params[:profile_id]
      @reviewable = Profile.find(params[:profile_id])
    elsif params[:event_id]
      @reviewable = Event.find(params[:event_id])
    else
      raise ActiveRecord::RecordNotFound, "Reviewable object not found"
    end
  end

  def set_review
    @review = @reviewable.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end