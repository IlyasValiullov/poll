class QuestionsController < ApplicationController
	before_action :set_poll
	before_action :check_author

	include PollsHelper

	def new
		@question = PollQuestion.new
	end

	def create
		@question = @poll.questions.new(question_params)
		if @question.save
			redirect_to @poll
		else
			render :new 
		end
	end

	def destroy
		@question = PollQuestion.find(params[:id])
		@question.destroy
		redirect_to poll_questions_url, notice: 'Question was successfully destroyed.'
	end

	def show
	end

	def index
		@current_poll_key = generate_vote_url(@poll)
		@questions = @poll.questions
	end

	private
	def question_params
		params.require(:poll_question).permit(:question)
	end
	def set_poll
		@poll = Poll.find(params[:poll_id])
	end
	def check_author
		if !is_author?(@poll)
			render inline: "<h1>Access denied</h1>", :status => 403 
		end
	end
end
