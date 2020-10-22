class Organizers::EventsController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @events = Event.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
  if @event.save
    redirect_to organizers_event_path(@event.id), notice: "イベントを登録しました"
  else
    render :new
  end
  end


  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
  if@event.update(event_params)
    redirect_to organizers_event_path(@event.id)
  else
    flash[:notice] = "イベントの更新ができませんでした"
    redirect_back(fallback_location: root_path)
  end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to organizers_events_path, notice: "イベントを削除しました"
  end

  private
  def event_params
    params.require(:event).permit(:participant_id, :date_and_time, :event_name, :image, :is_active, :content, :number_of_reservations)
  end

end
