class Public::ParticipantsController < ApplicationController
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

  private 
  def participant_params
    params.require(:participant).permit(:nickname, :email, :telephone_number, :is_deleted)
  end
end
