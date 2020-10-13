class Public::EventCommentsController < ApplicationController
    before_action :authenticate_participant!

	def create
		@event = Event.find(params[:event_id])
        @event_comment = current_participant.event_comments.new(event_comment_params)
		@event_comment.participant_id = current_participant.id
		@event_comment.event_id = @event.id
	 if @event_comment.save
	 	flash[:success] = "Comment was successfully created."
	    redirect_back(fallback_location: root_path)
	 else
		redirect_back(fallback_location: root_path)
	 end
	end

	private

	def event_comment_params
		params.require(:event_comment).permit(:comment, :event_id, :participant_id)
	end

end