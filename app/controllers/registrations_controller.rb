class RegistrationsController < ApplicationController
	before_action :require_signin
	def create
		@event = Event.find_by(slug: params[:event_id])
		@already_registered = Registration.already_registered?(current_user.id,@event.id)
		if(@already_registered.blank? != true)
			redirect_to @event, :alert => "You have already registered for '#{@event.name}'"
		else
		@registration = @event.registrations.new
		@registration.user = current_user
		if @registration.save 
			redirect_to @event, :notice => "Congrats!  you have registered for '#{@event.name}'"
		else
			redirect_to @event, :alert => "Oops! something went wrong."
		end
	 end
   end
end
