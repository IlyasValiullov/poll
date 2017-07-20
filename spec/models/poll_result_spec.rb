require 'rails_helper'

RSpec.describe PollResult, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context 'associations' do
  	let(:user) { User.create(email: "a@a.com", password: "111222") }
  	let(:poll) { Poll.create(title: "City poll", author: user) }
  	let(:question) { PollQuestion.create(poll: poll, question: "Will destroy your building?")}
  	let(:answer_yes) { PollQuestionAnswer.create(question: question, answer: "Yes")}
  	let(:answer_no) { PollQuestionAnswer.create(question: question, answer: "No")}
  	let(:result) {PollResult.create(user: user, 
  																	poll: poll,
  																	question: question,
  																	answer: answer_yes)}
  	it 'User.polls' do
  		expect(user.polls).to eq([poll])
  	end
  	it 'User.results' do
  		expect(user.results).to eq([result])
  	end
  	# context "User.answers.polls" do
  	# 	expect(user.answers.polls).to eq([])
  	# end
  end
  #check registrate new poll result
  #check get result by poll
  #check get all result by owner

end
