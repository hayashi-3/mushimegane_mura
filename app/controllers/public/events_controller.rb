class Public::EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:participant_id, :date_and_time, :event_name, :image, :is_active, :content, :number_of_reservations)
  end

end
