class EventsController < ApplicationController
	before_action :require_signin, only: ['update','create','destroy']
	before_action :event_of_the_month
	def events
		@events = Event.all
		render :events
	end

	def gallery
	   @events = Event.all 
	   render :gallery 
	end

	def contact
	  render :contact 
	end

	def post_mail
	 flash.now[:notice] = "Email Sent" 
	 render :contact
	end

	def index
		@recent_events = Event.recent_events
		@upcoming_events = Event.upcoming_events
	end

	def new
		@event = Event.new
	end

    def edit
     @event = Event.find_by(slug: params[:id])
    end

    def update

    	@event = Event.find_by(slug: params[:id])
    	if @event.update(event_params)
    		redirect_to @event, notice: 'Successfully updated.'
    	else
    	 render :edit
    	end
    end
	def show
		@event = Event.find_by(slug: params[:id])
		@recent_events = Event.recent_events
		if current_user
		  @current_like = current_user.likes.find_by(event_id: @event.id)
	   end
	end

	def destroy
		@event = Event.find_by(slug: params[:id])
		if @event.destroy
		 @event.remove_image!
		 redirect_to events_path, notice: 'Successfully deleted.'
		else
		 redirect_to events_path, notice: "Event deletion failed."
		end
	end

	def create
		@event = Event.new(event_params)
		if @event.save
		 redirect_to @event, notice: 'Event successfully created.' 
		else
			render :new
		end
	end

	private
	def event_params
		params.require(:event).permit(:name, :location,:starts_at, :image, :description, :category_ids => [])
	end
	def event_of_the_month
		@event_of_the_month = Event.event_of_the_month
	end
end
