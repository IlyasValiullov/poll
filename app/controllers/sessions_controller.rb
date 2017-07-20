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
  	#User.authenticate(params[:email], params[:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:user_id] = user.id
      redirect_to polls_path
    else 
      flash[:login_failed] = true
      render :new
    end

  	# @auth_user = User.find_by(email: params[:email]).try(:authenticate, params[:pass]) 
   #  if !@auth_user.nil?
   #    session[:user_id] = @auth_user.id
   #    redirect_to 
   #  else
   #    @auth_user = User.new
   #    render :login
   #  end
  end

  def destroy
  	@_current_user = session[:user_id] = nil
    redirect_to root_url
  end
end
