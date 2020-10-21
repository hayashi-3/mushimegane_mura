class Organizers::HomesController < ApplicationController
  before_action :authenticate_organizer!

  def top
    @events = Event.order("created_at DESC").where('date_and_time >= ?', DateTime.now).page(params[:page]).per(15)
  end

end
