require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context '#create' do
  	let(:user) { User.new(email: "a@a.com", password: "111222") }
  	it 'user create' do
  		expect(user.save).to be_truthy
  	end
  	it 'email uniq check' do
      u1 = User.create(email: "a@a.com", password: "111222")
  		u = User.new(email: "a@a.com", password: "111222")
  		expect { u.save!(validate: false) }.to raise_error.with_message(/duplicate key value/)
  	end
  end


  # context 'associations' do
  # 	let(:user) { User.create(email: "a@a.com", password: "111222") }
  # 	let(:poll) { Poll.create(title: "City poll", author: user) }
  # 	let(:question) { PollQuestion.create(poll: poll, question: "Will destroy your building?")}
  # 	let(:answer_yes) { PollQuestionAnswer.create(question: question, answer: "Yes")}
  # 	let(:answer_no) { PollQuestionAnswer.create(question: question, answer: "No")}
  # 	let(:result) {PollResult.create(user: user, 
  # 																	poll: poll,
  # 																	question: question,
  # 																	answer: answer_yes)}
  # 	it 'User.polls' do
  # 		expect(user.polls).to eq([poll])
  # 	end
  # 	it 'User.results' do
  # 		expect(user.results).to eq([result])
  # 	end
  # 	# context "User.answers.polls" do
  # 	# 	expect(user.answers.polls).to eq([])
  # 	# end
  # end
  
end
