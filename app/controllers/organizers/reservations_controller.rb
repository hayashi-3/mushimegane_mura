class Organizers::ReservationsController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @event = Event.find(params[:event_id])
    @reservations = @event.reservations.all
    @participant = Participant.find_by(params[:participant_id])
  end

  private

  def reservation_params
    params.permit(:participant_id, :event_id, :attendance_status)
  end

end
