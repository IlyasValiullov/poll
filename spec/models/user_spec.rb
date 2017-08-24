require 'rails_helper'

RSpec.describe User, type: :model do

	describe "create" do
		
		let(:user) { User.new(email: "a@a.com", password: "111222") }

		it 'success' do
			expect(user.save).to be_truthy
		end

		context "when email not uniq" do
			it 'raise error' do
				u1 = User.create(email: "a@a.com", password: "111222")
				u = User.new(email: "a@a.com", password: "111222")
				expect { u.save!(validate: false) }.to raise_error.with_message(/duplicate key value/)
			end
		end
	end

	describe "accessible_polls" do
		context "when has access to polls" do
			it "get array with all access polls"
		end
	end

	describe "destroy" do
		context "when has accessed polls" do
			it "destroy access records"
		end
	end
	
end
