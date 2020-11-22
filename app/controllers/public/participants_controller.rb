class Public::ParticipantsController < ApplicationController
  before_action :authenticate_participant!
  before_action :correct_participant
  before_action :guest_user, only: [:edit, :update, :unsubscribe]

  def correct_participant
    participant = Participant.find(params[:id])
    if current_participant != participant
      redirect_to participant_path(current_participant)
    end
  end

  def guest_user
    @participant = Participant.find_by(email: 'guest@example.com')
    if @participant == current_participant
      flash[:notice] = 'ゲストユーザーは編集・退会が出来ません'
      redirect_to root_path
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

  private 
  def participant_params
    params.require(:participant).permit(:nickname, :email, :telephone_number, :is_deleted)
  end

end
