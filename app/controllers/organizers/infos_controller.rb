class Organizers::InfosController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @infos = Info.order(id: "DESC").page(params[:page]).per(20)
  end

  def new
    @info = Info.new
    @participant = Participant.find(params[:participant_id])
  end

  def confirm
    @info = Info.new(info_params)
    @participant = Participant.find(params[:participant_id])
    session[:info] = @info
      if @info.invalid?
        render :new
      end
  end

  def back
    @info = Info.new(session[:info])
    @participant = Participant.find(params[:participant_id])
    session.delete(:info)
		render :new
  end

  def create
    @info = Info.new(info_params)
    @participant = Participant.find(params[:participant_id])
    @info.participant_id = @participant.id
    if @info.save
      InfoMailer.info_mail(@info, @participant).deliver_now
      redirect_to infos_path
    else
      flash.now[:notice] = '入力に誤りがあります'
      render :new
    end
  end

  private
  def info_params
    params.require(:info).permit(:message)
  end

end
