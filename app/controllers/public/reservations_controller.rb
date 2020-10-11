class Public::ReservationsController < ApplicationController
  before_action :authenticate_participant!

  def index
    @participant = Participant.find(current_participant.id)
    @reservations = @participant.reserved_events.all
  end

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = current_participant.reservations.new(reservation_params)
    @reservation.event_id = @event.id
    if @reservation.save
      redirect_to thanks_path
    else
      render :new
      @reservation = Reservation.new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:participant_id, :event_id, :attendance_status)
  end

end