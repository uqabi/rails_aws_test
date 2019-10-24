class ApplicationController < ActionController::Base
   def require_signin
   	unless session[:user_id]
   	session[:intended_url] = request.url
   	redirect_to new_session_path, :notice => "Sign in is required."
   end
   end

   def current_user
   	user = User.find(session[:user_id]) if session[:user_id]
   end

   helper_method :current_user
   helper_method :require_signin
end
