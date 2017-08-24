require 'rails_helper'

RSpec.describe PollQuestionAnswer, type: :model do
	let(:user) { User.create(email: "a@a.com", password: "111222") }
  let(:poll) { Poll.create(author: user, title: "City poll") }
  let(:question) { poll.questions.create(question: "Are there enough parks in the city?") }
  let(:answer) {question.answers.new}

	describe "create" do
		context "when exist answer and question" do

			it "success" do
				result = fill_and_save(answer: "Yes", question: question)
				expect(result).to be_truthy
			end
			it "answer was included in question" do
				result = fill_and_save(answer: "Yes", question: question)
				expect(question.answers).to include(answer)
			end
		end
		context "when doesn't exist answer" do
			it "raise error" do
				result = fill_and_save(answer: "Yes")
				expect(result).to be_falsey
			end
		end
		context "when doesn't exist question" do
			it "raise error" do
				result = fill_and_save(question: question)
				expect(result).to be_falsey
			end
		end
	end
	
	def fill_and_save params
		answer.question = params.fetch(:question, nil)
		answer.answer = params.fetch(:answer, nil)
		answer.save
	end
end