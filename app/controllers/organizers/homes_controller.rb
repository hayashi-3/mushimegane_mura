class Organizers::HomesController < ApplicationController
  before_action :authenticate_organizer!

  def top
    @events = Event.order("date_and_time").where('date_and_time >= ?', DateTime.now).page(params[:page]).per(10)
  end

end
