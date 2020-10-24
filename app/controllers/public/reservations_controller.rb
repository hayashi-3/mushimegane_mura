class Public::ReservationsController < ApplicationController
  before_action :authenticate_participant!
  before_action :correct_participant

  def correct_participant
    participant = Participant.find(current_participant.id)
      if current_participant != participant
        redirect_to participant_path(current_participant)
      end
  end

  def index
    @participant = Participant.find(current_participant.id)
  end

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
    reservation_count = Reservation.where(event_id: @event.id).where(attendance_status: 1).count
    reservation_max_count = @event.number_of_reservations
    @reservation_flag = true
    if reservation_count >= reservation_max_count
      @reservation_flag = false
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = current_participant.reservations.new(reservation_params)
    reservation_count = Reservation.where(event_id: @event.id).where(attendance_status: 1).count
    reservation_max_count = @event.number_of_reservations
    @reservation_flag = true
  if reservation_max_count > reservation_count
    if @reservation.save
      redirect_to thanks_path
    else
      render :new
      @reservation = Reservation.new
    end
  else
    redirect_to owabi_path
  end
  end

  def destroy
    @event = Event.where(id: params[:event_id]).where(participant_id: params[:participant_id])
    @participant = Participant.find_by(id: current_participant.id)
    @reservation = current_participant.reservations.find_by(event_id: params[:event_id])
    @reservation.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:participant_id, :event_id, :attendance_status)
  end

end