class Organizers::ReservationsController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @event = Event.find(params[:event_id])
    @reservations = @event.reservations.all
    @participant = Participant.find_by(params[:participant_id])
  end

  def destroy
    @event = Event.where(id: params[:event_id]).where(participant_id: params[:participant_id])
    @participant = Participant.find_by(id: params[:id])
    @reservation = @participant.reservations.find_by(event_id: params[:event_id])
    @reservation.destroy
    redirect_to organizers_event_reservations_path, notice: "予約を削除しました"
  end

  private

  def reservation_params
    params.permit(:participant_id, :event_id, :attendance_status)
  end

end
