class Organizers::InfosController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @infos = Info.order(id: "DESC").page(params[:page]).per(15)
  end

  def new
    @info = Info.new
    @participant = Participant.find(params[:participant_id])
  end

  def show
    @info = Info.find(params[:id])
    @participant = Participant.find(params[:participant_id])
  end

  def confirm
    @info = Info.new(info_params)
    @info.participant_id = params[:participant_id]
    session[:info] = @info
    if @info.invalid?
      @participant = Participant.find(params[:participant_id])
      render :new
    end
  end

  def back
    @info = Info.new(session[:info])
    @info.participant_id = params[:participant_id]
    session.delete(:info)
    @participant = Participant.find(params[:participant_id])
		render :new
  end

  def create
    @info = Info.new(info_params)
    @participant = Participant.find(params[:participant_id])
    @info.participant_id = @participant.id
    if @info.save
      InfoMailer.info_mail(@info, @participant).deliver_now
      redirect_to organizers_participant_info_path(@participant, @info)
    else
      render :confirm
    end
  end

  private
  def info_params
    params.require(:info).permit(:message)
  end

end
