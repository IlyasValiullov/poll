class AnswersController < ApplicationController
  before_action :set_poll
  before_action :set_question
  before_action :check_author

  include PollsHelper

  def new
    @answer = PollQuestionAnswer.new
  end

  def create
    @answer = PollQuestionAnswer.new(answer_params)
    @answer.question = @question
    if @answer.save
      redirect_to poll_question_answers_path(@poll, @question)
    else
      render :new 
    end
  end

  def destroy
  end

  def show
  end

  def index
    @answers = PollQuestionAnswer.where(question: params[:question_id])
  end

  private
    def answer_params
      params.require(:poll_question_answer).permit(:answer)
    end

    def set_poll
      @poll = Poll.find(params[:poll_id])
    end

    def set_question
      @question = PollQuestion.find(params[:question_id])
    end

    def check_author
      if !is_author?(@poll)
        render inline: "<h1>Access denied</h1>", :status => 403 
      end
    end
end
