class SessionsController < ApplicationController
	def new
		if !current_user.nil?
			redirect_to polls_path
		else
			render :new
		end
	end

	def create
		if user = User.find_by(email: params[:email]).try(:authenticate, params[:password]) 
			session[:user_id] = user.id
			redirect_to polls_path
		else 
			flash[:login_failed] = true
			render :new
		end
	end

	def destroy
		@_current_user = session[:user_id] = nil
		redirect_to root_url
	end
end
