class Organizers::HomesController < ApplicationController
  before_action :authenticate_organizer!

  def top
    @events = Event.order("date_and_time").where('date_and_time >= ?', DateTime.now).page(params[:page]).per(10)
  end

  private
  def event_params
    params.require(:event).permit(:participant_id, :date_and_time, :event_name, :image, :is_active, :content, :number_of_reservations)
  end

end
