class Public::ReservationsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @participant = Participant.find(params[:participant_id])
    @reservation = Reservation.new(params[:id])
    if @reservation.save
      thanks_path
    else
      render "new"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:participant_id, :event_id, :number_of_reserved, :attendance_status)
  end

end