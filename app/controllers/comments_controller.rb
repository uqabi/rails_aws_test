class CommentsController < ApplicationController
	before_action :require_signin, only: ['update','create','destroy']
	def create
	 @event = Event.find_by(slug: params[:event_id])
	 @comment = @event.comments.new()
	 @comment.user = current_user 
	 @comment.comment = params[:comment]
	 if @comment.save
	    redirect_to @event, :notice => "Comment successfully posted." 
	 else 
	 	flash[:form_errors] = @comment.errors.full_messages
	 	redirect_to @event
	 end 
	end
end
