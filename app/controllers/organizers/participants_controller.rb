class Organizers::ParticipantsController < ApplicationController
  before_action :authenticate_organizer!
  before_action :guest_organizer, only: [:edit, :update]
  before_action :set_participant, only: [:show, :edit, :update]

  def guest_organizer
    @organizer = Organizer.find_by(email: 'guest@organizer.com')
    if @organizer == current_organizer
      flash[:notice] = 'ゲストユーザーは編集が出来ません'
      redirect_to organizers_root_path
    end
  end

  def index
    @participants = Participant.all
  end

  def show
  end

  def edit
  end

  def update
  if@participant.update(participant_params)
    redirect_to organizers_participant_path(@participant.id), notice: "会員情報の更新ができました"
  else
    render :edit, notice: "会員情報が保存できませんでした"
  end
  end

  private
  def participant_params
    params.require(:participant).permit(:nickname, :telephone_number, :is_deleted, :email)
  end

  def set_participant
    @participant = Participant.find(params[:id])
  end

end
