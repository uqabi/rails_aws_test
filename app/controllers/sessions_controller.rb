class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.authenticate(params[:email], params[:password])
		if user 
		 session[:user_id] = user.id
		 redirect_to session[:intended_url] || events_path
		else
	     flash.now[:notice] = "Email/password is incorrect."
		 render :new
		end
	end

	def destroy
	  session["user_id"] = nil 
	  redirect_to new_session_path
	end
end
