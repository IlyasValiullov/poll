class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:show, :edit, :update, :destroy]

  include PollsHelper
  # GET /polls
  # GET /polls.json
  def index
    if current_user.nil?
      redirect_to login_path
    else
      @current_user = User.find(session[:user_id])
      @polls = @current_user.polls
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    redirect_to poll_questions_path(@poll)
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll.author = current_user
    
    if @poll.save
      redirect_to polls_path, notice: 'Poll was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    if @poll.update(poll_params)
      redirect_to polls_path, notice: 'Poll was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:title)
    end

    def check_author
      if !is_author?(@poll)
        render inline: "<h1>Access denied</h1>", :status => 403 
      end
    end

end
