# app/services/event_filter.rb
class EventFilter
  attr_reader :events, :params

  def initialize(params)
    @params = params
    @events = Event.includes(:participant, :logistic, :tickets, :event_rule)
  end

  def filter
    filter_by_start_time
    filter_by_location
    filter_by_tags
    filter_by_search
    filter_by_participant_type
    filter_by_privacy
    filter_by_paid
    @events.order(created_at: :desc)
  end

  private

  def filter_by_start_time
    return unless params[:start_time].present?
    @events = @events.where('start_time >= ?', params[:start_time])
  end

  def filter_by_location
    return unless params[:location].present?
    @events = @events.where('location ILIKE ?', "%#{sanitize_sql_like(params[:location])}%")
  end

  def filter_by_tags
    return unless params[:tags].present?
    tags = params[:tags].split(',').map(&:strip)
    @events = @events.where('tags @> ARRAY[?]::text[]', tags)
  end

  def filter_by_search
    return unless params[:search].present?
    search_term = "%#{sanitize_sql_like(params[:search])}%"
    @events = @events.where('name ILIKE ? OR description ILIKE ?', search_term, search_term)
  end

  def filter_by_participant_type
    return unless params[:participant_type].present?
    @events = @events.joins(:participant).where(participant: { participant_type: params[:participant_type] })
  end

  def filter_by_privacy
    return unless params[:is_private].present?
    is_private = ActiveRecord::Type::Boolean.new.cast(params[:is_private])
    @events = @events.joins(:participant).where(participant: { is_private: is_private })
  end

  def filter_by_paid
    return unless params[:is_paid].present?
    is_paid = ActiveRecord::Type::Boolean.new.cast(params[:is_paid])
    @events = @events.joins(:participant).where(participant: { is_paid: is_paid })
  end

  def sanitize_sql_like(string)
    ActiveRecord::Base.sanitize_sql_like(string)
  end
end