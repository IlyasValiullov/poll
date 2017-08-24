require 'rails_helper'

RSpec.describe "User", type: :feature do
  describe "login" do
    context "when user not authorized" do
      it "loged in"
      it "get redirect to home page"
      it "have link to polls"
    end
    context "when user authorized" do
      context "on home page" do
        it "button login doesn't exist"
      end
      context "when going to login url" do
        it "redirect to home page"
      end
    end    
  end

  describe "sign up" do
    context "when user not authorized" do
      it "signed up" 
      it "get hello"
      it "get redirect to home page"
    end
    context "when user authorized" do
      context "on home page" do
        it "button sign up doesn't exist"
      end
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