class Public::ReservationsController < ApplicationController

  def edit
    @event = Event.find(params[:event_id])
  end

end
