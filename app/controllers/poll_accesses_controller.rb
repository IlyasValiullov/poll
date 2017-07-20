class PollAccessesController < ApplicationController
  def create
    @poll = Poll.where(key: session[:key]).first
  	if session[:user_id].nil?
  		redirect_to login_path
  	elsif session[:key].nil? or @poll.nil?
  		render inline: "<h1>Bad request</h1>", :status => 400 
  	else 
  		PollAccess.create(poll: @poll, user: current_user)
  		redirect_to new_poll_result_path(@poll)
  	end
  end

  def check
    @poll = Poll.where(key: params[:key]).first
  	session[:key] = params[:key]
  	if session[:user_id].nil?
  		redirect_to login_path
    elsif session[:key].nil? or @poll.nil?
      render inline: "<h1>Bad request</h1>", :status => 400 
  	else
  		render :create
  	end

  	# params[:key]
  end

end
