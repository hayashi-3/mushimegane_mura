class Public::EventCommentsController < ApplicationController
		before_action :authenticate_participant!
		before_action :set_event

	def create
	  @event_comment = current_participant.event_comments.new(event_comment_params)
	  @event_comment.participant_id = current_participant.id
	  @event_comment.event_id = @event.id
	  if @event_comment.save
	    redirect_back(fallback_location: root_path)
	  else
		  redirect_back(fallback_location: event_path(@event))
	  end
	end

	def destroy
      @event_comment = current_participant.event_comments.find(params[:id])
      @event_comment.destroy
      redirect_back(fallback_location: root_path)
	end

	private
	def event_comment_params
		params.require(:event_comment).permit(:comment, :event_id, :participant_id)
	end

	def set_event
		@event = Event.find(params[:event_id])
  end

end