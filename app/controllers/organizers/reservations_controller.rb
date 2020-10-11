class Organizers::ReservationsController < ApplicationController
  before_action :authenticate_organizer!

  def index
  end

  def show
    @event = Event.find(params[:id])
    @reservations = @event.reservations.all
  end

  private

  def reservation_params
    params.require(:reservation).permit(:participant_id, :event_id, :attendance_status)
  end

end
