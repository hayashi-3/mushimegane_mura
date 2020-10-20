class Public::EventCommentsController < ApplicationController
    before_action :authenticate_participant!

	def create
	  @event = Event.find(params[:event_id])
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
      @event = Event.find(params[:event_id])
      @event_comment = current_participant.event_comments.find_by(params[:participant_id])
      @event_comment.destroy
      redirect_back(fallback_location: root_path)
	end

	private

	def event_comment_params
		params.require(:event_comment).permit(:comment, :event_id, :participant_id)
	end

end