class Organizers::InfosController < ApplicationController

  def index     
  end

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(info_params)
    if @info.after_save
      InfoMailer.info_mail(@info).deliver
      flash[:success] = 'メールを受付ました'
      redirect_to organizers_info_path
    else
      render :new
    end
  end

  private
  def info_params
    params.require(:info).permit(:message, :participant_id)
  end

end
