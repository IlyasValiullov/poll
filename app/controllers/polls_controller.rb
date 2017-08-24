class PollsController < ApplicationController
	before_action :set_poll, only: [:show, :edit, :update, :destroy]
	before_action :check_author, only: [:show, :edit, :update, :destroy]

	include PollsHelper

	def index
		if current_user.nil?
			redirect_to login_path
		else
			@current_user = User.find(session[:user_id])
			@polls = @current_user.polls
		end
	end

	def show
		redirect_to poll_questions_path(@poll)
	end

	def new
		@poll = Poll.new
	end

	def edit
	end

	def create
		@poll = Poll.new(poll_params)
		@poll.author = current_user
		
		if @poll.save
			redirect_to polls_path, notice: 'Poll was successfully created.'
		else
			render :new
		end
	end

	def update
		if @poll.update(poll_params)
			redirect_to polls_path, notice: 'Poll was successfully updated.'
		else
			render :edit
		end
	end


	def destroy
		@poll.destroy
		redirect_to polls_url, notice: 'Poll was successfully destroyed.'
	end

	private
	def set_poll
		@poll = Poll.find(params[:id])
	end

	def poll_params
		params.require(:poll).permit(:title)
	end

	def check_author
		if !is_author?(@poll)
			render inline: "<h1>Access denied</h1>", :status => 403 
		end
	end

end
