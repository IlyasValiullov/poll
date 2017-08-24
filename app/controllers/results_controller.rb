class ResultsController < ApplicationController
	before_action :set_poll
	before_action :check_can_vote

	include PollsHelper
	include ResultHelper

	def new
		@poll_results = PollInfo.show(@poll.id)
	end

	def create
		poll_id = params[:poll].keys.first
		@poll = Poll.find(poll_id.to_i)
		params[:poll][poll_id]["answers"].each {|key, value| 
			@question = PollQuestion.find(key)
			@answer = PollQuestionAnswer.find(value)
			@poll.results.create(user: current_user, question: @question, answer: @answer)
		}

		redirect_to poll_results_path(@poll)

	end

	def index
		if params[:format] == "json"

			last_update = PollResult.where(poll_id: params[:poll_id]).order(updated_at: "DESC").first.updated_at

			if session[:last_update] != last_update.to_s
				session[:last_update] = last_update.to_s 
			else
				head :ok
				return
			end

		else
			if session[:last_update] != last_update.to_s
				session[:last_update] = last_update.to_s 
			end
		end
		@result = PollResult.where(poll_id: params[:poll_id])
		@poll_results = ResultStatistic.get(@poll.id)

		respond_to do |format|
			format.html {}
			format.json {render :json=> @poll_results.to_json}
		end
	end

	def destroy
	end

	private

	def set_poll
		@poll = Poll.find(params[:poll_id])
	end

	def check_can_vote
		render inline: "<h1>Access denied</h1>", :status => 403 if !can_vote?(@poll) and !is_author?(@poll)
	end
end
