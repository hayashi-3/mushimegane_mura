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

  def destroy
    @event = Event.find(params[:event_id])
    @reservations = current_participant.reservations.find_by(@event)
    @participant = Participant.find(params[:participant_id])
    @reservation.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:participant_id, :event_id, :attendance_status)
  end

end