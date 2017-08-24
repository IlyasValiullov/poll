require 'rails_helper'

RSpec.describe PollQuestion, type: :model do
	let(:user) { User.create(email: "a@a.com", password: "111222") }
  let(:poll) { Poll.create(author: user, title: "City poll") }
  let(:question_text) {"Are there enough parks in the city?"}
  let(:question) { poll.questions.new }
	describe "create" do
		context "when exist question and poll" do
			it "success" do
				result = fill_and_save(poll: poll, question: question_text)
				expect(result).to be_truthy
			end

			it "question was included in poll" do
				result = fill_and_save(poll: poll, question: question_text)
				expect(poll.questions).to include(question)
			end
		end
		context "when doesn't exist question" do
			it "raise error" do
				result = fill_and_save(poll: poll)
				expect(result).to be_falsey
			end
		end
		context "when doesn't exist poll" do
			it "raise error" do
				result = fill_and_save(question: question_text)
				expect(result).to be_falsey
			end
		end
	end

	describe "destroy" do
		context "when has answers" do
			it "destroy nested answers" do
				result = fill_and_save(poll: poll,question: question_text)
				a = question.answers.create(answer: "Yes")
				question.destroy
				expect(a.destroyed?).to be_truthy
			end
		end	
	end

	def fill_and_save params
		question.question = params.fetch(:question, nil)
		question.poll = params.fetch(:poll, nil)
		question.save
	end

end