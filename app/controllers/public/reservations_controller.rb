class Public::ReservationsController < ApplicationController

  def edit
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.new
  end

  def update
    if @event.update(update_event_params)
      redirect_to root_path
    else
      render "edit"
      @event = Event.find(params[:event_id])
      @reservation = @event.reservations.new
    end
  end

  private

  def update_event_params
    params.require(:event).permit(:date_and_time, :event_name, :content, :is_active, reservations_attributes: [:number_of_reservations, :_destroy, :id])
  end

end