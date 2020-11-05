class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]

    if @range == '1'
      @event_name = Event.search(search,word)
    else
      @event_date = Event.search(search,word)
    end
  end
end
