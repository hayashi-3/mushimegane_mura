class Organizers::EventCommentsController < ApplicationController
  before_action :authenticate_organizer!

  def index
    @event_comments = EventComment.all
  end

  def destroy
    
  end

  private

	def event_comment_params
		params.require(:event_comment).permit(:comment, :event_id, :participant_id)
	end

end
