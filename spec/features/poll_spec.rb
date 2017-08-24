require 'rails_helper'

RSpec.describe "Poll", type: :feature do
  describe "index" do
    context "nav bar has" do
      it "create new poll link"
    end
    context "table has" do
      it "all user's records" 
    end
    context "row has" do
      it "name column"
      it "show link"
      it "destroy link"
    end
  end

  describe "new" do
    context "poll form has" do
      it "name input" 
      it 'create button'
    end
  end

  describe "create" do
    it "get redirect to index page"
    it "create poll shows in table"
  end

  describe "show" do
    context "nav bar has" do
      it "create new question link"
    end
    context "table has" do
      it "all answers for this question"
    end
    context "row has" do
      it "answer column"
      it "show link"
      it "destroy link"
    end
  end

  #   it "sign up" do
  #     visit("/")
  #     click_link("Registration")
      
  #     within("#registration_form") do
  #       fill_in 'Email', with: 'ccc'
  #       fill_in 'Password', with: '2222'
  #     end
  #     click_button 'Registrate'
  #     expect(page).to have_content 'Listing polls'
  #   end
  # end
end