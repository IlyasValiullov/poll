require 'rails_helper'

RSpec.describe PollAccess, type: :model do
	describe "create" do
		context "when exist poll and user" do
			it "success"
		end
		context "when doesn't exist poll" do
			it "raise error"
		end
		context "when doesn't exist user" do
			it "raise error"
		end
	end

	describe "destroy" do
		it "exist concern poll"
		it "exist concern user"
	end
end
