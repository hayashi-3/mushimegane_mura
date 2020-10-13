class Organizers::InfosController < ApplicationController
  before_action :authenticate_organizer!

  def index     
  end

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(info_params)
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
    params.require(:info).permit(:message)
  end

end
