require 'rails_helper'

RSpec.describe Poll, type: :model do
	let(:user) { User.create(email: "a@a.com", password: "111222") }

	let(:poll) { Poll.new }
	describe ".create" do
		context "when with title and author" do
			it "is valid" do
				fill_poll(poll, {user: user,title: "City poll"})
				expect(poll).to be_valid
			end
			it "user have poll" do
				fill_and_save_poll(poll, {user: user,title: "City poll"})
				expect(user.polls.last).to eq(poll)
			end
		end
		context "when without title" do
			it "is invalid" do
				fill_poll(poll, {user: user})
				poll.valid?
				expect(poll.errors[:title]).to include("can't be blank")
			end
		end
		context "when without author" do
			it "is invalid" do
				poll.title = "City poll"
				poll.valid?
				expect(poll.errors[:author]).to include("can't be blank")
			end
		end

		context "when dublicate poll name per user" do
			it "is invalid"

		end

		context "when two user share poll name " do
			it "is valid"
			
		end
	end

	describe ".questions" do
		context "when create new question" do
			it "have question" do
				fill_and_save_poll(poll, {user: user,title: "City poll"})
				a = PollQuestion.create(poll: poll, question: "Will destroy buildings?")
				expect(poll.questions).to include(a)
			end
		end
		context "when doesn't have concerned questions" do
			it "is empty"
      # be_empty
    end
  end

  describe ".destroy" do
  	context "when has questions" do
  		it "destroy nested questions" do
  			fill_and_save_poll(poll, {user: user,title: "City poll"})
  			q = poll.questions.create(question: "Will destroy buildings?")
  			poll.destroy
  			expect(q.destroyed?).to be_truthy
  		end
  	end

  	context "when has accessed users" do
  		it "destroy concerned accesses"
  	end

  	context "when has results" do
  		it "destroy concerned results"
  	end
  end
  

  def fill_and_save_poll(poll, params)
  	fill_poll(poll, params)
  	poll.save
  end

  def fill_poll(poll, params)
  	poll.author = params.fetch(:user, nil)
  	poll.title = params.fetch(:title, nil)
  end
end
