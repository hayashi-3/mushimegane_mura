class Public::EventsController < ApplicationController
  before_action :authenticate_participant!, only: [:show]

  def index
    @events = Event.order("created_at DESC").page(params[:page]).per(15)
    held_event_ids = Event.where.not(date_and_time: nil).pluck(:id)
    @held_events = Event.where(id: held_event_ids).where('date_and_time >= ?', DateTime.current)
  end

  def show
    @event = Event.find(params[:id])
    @event_comment = EventComment.new
    @event_comments = EventComment.all
  end

  private
  def event_params
    params.require(:event).permit(:participant_id, :date_and_time, :event_name, :image, :is_active, :content, :number_of_reservations)
  end

end
