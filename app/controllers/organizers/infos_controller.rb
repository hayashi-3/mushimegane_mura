class Organizers::InfosController < ApplicationController
  before_action :authenticate_organizer!

  def index     
  end

  def new
    @info = Info.new
    @participant = Participant.find(params[:participant_id])
  end

  def create
    @info = Info.new(info_params)
    @participant = Participant.find(params[:participant_id])
    if @info.save
      InfoMailer.info_mail(@info, @participant).deliver_now
      flash[:success] = 'メールを受付ました'
      redirect_to organizers_participant_infos_path
    else
      render :new
    end
  end

  private
  def info_params
    params.require(:info).permit(:message, :participant_id)
  end

end
