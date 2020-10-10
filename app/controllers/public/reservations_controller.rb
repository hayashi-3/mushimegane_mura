class Public::ReservationsController < ApplicationController
  before_action :authenticate_participant!

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.create!(participant_id: current_participant.id, event_id: params[:event_id])
    redirect_to thanks_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:participant_id, :event_id, :attendance_status)
  end

end