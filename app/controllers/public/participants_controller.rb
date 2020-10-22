class Public::ParticipantsController < ApplicationController
  before_action :authenticate_participant!
  before_action :correct_participant
  before_action :reservations_attendance_status_false, only: [:unsubscribe]

  def correct_participant
    participant = Participant.find(params[:id])
    if current_participant != participant
      redirect_to participant_path(current_participant)
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update(participant_params)
      redirect_to participant_path(participant_params), notice: "更新しました"
    else
      render :edit
    end
  end

  def withdrawal
  end

  def unsubscribe
    @participant.update(is_deleted: true)
    if @invalid_reservation.size >= 1
      @invalid_reservation.update_all(attendance_status: 0)
    end
    reset_session
    redirect_to root_path, notice: "ご利用ありがとうございました"
  end

  def reservations_attendance_status_false
    @participant = Participant.find(current_participant.id)
    @invalid_reservation = Reservation.where(event_id: @participant.reserved_events.ids).where(attendance_status: 1)
  end

  private 
  def participant_params
    params.require(:participant).permit(:nickname, :email, :telephone_number, :is_deleted)
  end

end
