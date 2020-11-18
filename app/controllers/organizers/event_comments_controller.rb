class Organizers::EventCommentsController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @event_comments = EventComment.all
  end

  def update
    @event_comment = Event_comment.find(params[:event_comment])
  end

  private

	def event_comment_params
		params.require(:event_comment).permit(:comment, :event_id, :participant_id)
	end

end
