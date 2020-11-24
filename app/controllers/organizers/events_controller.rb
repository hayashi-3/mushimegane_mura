class Organizers::EventsController < ApplicationController
  before_action :authenticate_organizer!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order("created_at DESC").page(params[:page]).per(5)
  end

  def show
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
  end

  def update
  if@event.update(event_params)
    redirect_to organizers_event_path(@event.id)
  else
    flash[:notice] = "イベントの更新ができませんでした"
    redirect_back(fallback_location: root_path)
  end
  end

  def destroy
    @event.destroy
    redirect_to organizers_events_path, notice: "イベントを削除しました"
  end

  private
  def event_params
    params.require(:event).permit(:participant_id, :date_and_time, :event_name, :image, :is_active, :content, :number_of_reservations)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
