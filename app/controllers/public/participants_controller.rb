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
    @participant = Participant.find(current_participant.id)
    @participant.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "ご利用ありがとうございました"
  end

  def reservations_attendance_status_false
    # 退会した会員のattendance_statusが１（参加）のものを探す
    invalid_reservation = Reservation.where(event_id: @event.id).where(attendance_status: 1)
    # もし会員の退会フラグが有効なら
    # attendance_statusを0（未参加）にして予約を解消する
  end


  private 
  def participant_params
    params.require(:participant).permit(:nickname, :email, :telephone_number, :is_deleted)
  end

end
