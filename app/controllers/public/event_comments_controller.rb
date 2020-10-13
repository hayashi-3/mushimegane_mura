class Public::EventCommentsController < ApplicationController
    before_action :authenticate_participant!

	def create
		@event_comment = EventComment.new(event_comment_params)
		@event_comment.participant_id = current.participant.id
	 if @event_comment.save
	 	flash[:success] = "Comment was successfully created."
	    redirect_back(fallback_location: root_path)
	 else
		render "create"
	 end
	end

	private

	def event_comment_params
		params.require(:event_comment).permit(:comment)
	end

end
end
