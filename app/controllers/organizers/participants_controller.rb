class Organizers::ParticipantsController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
  if@participant.update(participant_params)
    redirect_to organizers_participant_path(@participant.id), notice: "会員情報の更新ができました"
  else
    redirect_back(fallback_location: root_path)  
  end
  end

  private
  def participant_params
    params.require(:participant).permit(:nickname, :telephone_number, :is_deleted, :email)
  end
end
