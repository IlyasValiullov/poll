class ResultsController < ApplicationController
  before_action :set_poll
  before_action :check_can_vote
  include PollsHelper

  def new
      @poll_results = []
      @temp_questions = []
      @temp_answers = []
      @poll_questions = PollQuestion.select("poll_questions.poll_id, 
        poll_questions.id, 
        poll_questions.question, 
        poll_question_answers.id as answer_id, 
        poll_question_answers.answer")
      .joins("INNER JOIN poll_question_answers 
        on poll_questions.id = poll_question_answers.question_id")
      .where(poll_id: @poll.id)
      answers = []

      @poll_questions.each do |quan|
        
        if !@temp_questions.include?(quan.id)
          @temp_questions << quan.id
          answers = []
          answers << { :answer_id => quan[:answer_id],
           :answer => quan[:answer], 
           :value => false }
           @poll_results << { :poll_id =>  quan[:poll_id],
            :question_id =>  quan[:id],
            :question =>  quan[:question],
            :answers=> answers }
        else
          answers << { :answer_id => quan[:answer_id],
             :answer => quan[:answer], 
             :value => false }
        end
      end

  end

  def create
    #@poll = Poll.find(params[:poll].keys.first)
    poll_id = params[:poll].keys.first
    @poll = Poll.find(poll_id.to_i)
    params[:poll][poll_id]["answers"].each {|key, value| 
      @question = PollQuestion.find(key)
      @answer = PollQuestionAnswer.find(value)
      PollResult.create(poll: @poll, user: current_user, question: @question, answer: @answer)
    }

    redirect_to poll_results_path(@poll)

  end

  def index
    @result = PollResult.where(poll_id: params[:poll_id])

    sql_query = 
    "SELECT 
      poll.*, 
      count(poll_results.user_id) as answer_count
      
    FROM 
      (
      select 
        poll_questions.id as question_id, 
        poll_questions.question as question, 
        poll_questions.poll_id as poll_id, 
        polls.title as poll_title, 
        poll_question_answers.answer as answer, 
        poll_question_answers.id as answer_id ,
        count(coalesce(poll_all_results.user_id,0)) as all_answer_count
      FROM
        public.poll_questions 
        INNER JOIN public.poll_question_answers AS poll_question_answers on
          poll_questions.id = poll_question_answers.question_id 
        INNER JOIN public.polls on
          polls.id = poll_questions.poll_id 

        LEFT OUTER JOIN public.poll_results AS poll_all_results ON
          poll_questions.id = poll_all_results.question_id
      where 
        poll_questions.poll_id = #{@poll.id}
      GROUP BY
        poll_questions.id,
        poll_questions.question,
        poll_questions.poll_id,
        polls.title,
        poll_question_answers.answer,
        poll_question_answers.id    
     ) as poll
      LEFT JOIN public.poll_results AS poll_results ON
        poll.question_id = poll_results.question_id AND 
        poll.answer_id = poll_results.answer_id

      

    GROUP BY
      poll.question_id,
      poll.question,
      poll.poll_id,
      poll.poll_title,
      poll.answer,
      poll.answer_id,
      poll.all_answer_count

    ORDER BY
      poll.poll_id,
      poll.question_id,
      poll.answer_id"

    # sql_file = File.open("sql/get_results.sql", "r")
    # sql_query = sql_file.read

    # sql_query.sub! "&param", "#{@poll.id}"
    
    byebug
    @poll_results = ActiveRecord::Base.connection.execute(sql_query)

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
