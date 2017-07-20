require 'rails_helper'
require 'pry-debugger'

RSpec.describe Poll, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  context "create" do
    let(:user) { User.create(email: "a@a.com", password: "111222") }
    let(:poll) { Poll.new(title: "City poll", author: user) }
    let(:question) { PollQuestion.new(poll: poll, question: "Will destroy your building?")}
    let(:answer_yes) { PollQuestionAnswer.new(question: question, answer: "Yes")}
    let(:answer_no) { PollQuestionAnswer.new(question: question, answer: "No")}

  
  	it 'Poll.create' do
  		expect(poll.save()).to be_truthy
  	end
  	it 'PollQuestion.create' do
  		expect(question.save()).to be_truthy
  	end
  	it 'PollQuestionAnswer.create' do
      answer_no.save()
      binding.pry
  		expect(answer_yes.save()).to be_truthy
  	end
  end

  # it 'question.answers' do
  # 	expect(poll.question[:first].answers).to include(answer_yes, answer_no)
  # end	
  




  #check created new poll

  #check get poll questions
  #check create poll question

  #check get poll question answers
  #check create poll question answer

end
