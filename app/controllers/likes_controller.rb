class LikesController < ApplicationController
	before_action :require_signin, only: ['update','create','destroy']
	def index
		redirect_to root_path
	end
	def create
		@event = Event.find_by(slug: params[:event_id])
		@like = @event.likes.new 
		@like.user = current_user
		if @like.save 
		  update_likes_count_on_event(@event.id)
		  redirect_to @event 
		else
			redirect_to @event, alert: "Oops! something went wrong"
		end
	end

	def destroy
		@event = Event.find_by(slug: params[:event_id])
		@likes = @event.likes.find_by(:user_id => current_user.id)
		if @likes.destroy 
			update_likes_count_on_event(@event.id)
			redirect_to @event 
		else
			redirect_to @event, alert: 'Oops! something went wrong!'
		end
	end

	private
    def update_likes_count_on_event(event_id)
    	 event = Event.find(event_id)
	     count = event.likes.size
	     event.update_column(:likes_count, count)
   end 
    
end
