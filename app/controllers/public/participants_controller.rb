class Public::ParticipantsController < ApplicationController
  before_action :authenticate_participant!

  def show
    @participant = Participant.find(params[:id])
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
  if @participant.update(participant_params)
    redirect_to participant_path(participant_params)
  else
    redirect_to "edit"
  end
  end

  def withdrawal
  end

  def unsubscribe
    @participant = Participant.find(current_participant.id)
    @participant.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private 
  def participant_params
    params.require(:participant).permit(:nickname, :email, :telephone_number, :is_deleted)
  end
end
