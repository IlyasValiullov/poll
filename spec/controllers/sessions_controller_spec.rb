require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end


  describe "after login redirect to polls list", :type => :feature do

    it "sign up" do
      visit("/")
      click_link("Registration")
      
      within("#registration_form") do
        fill_in 'Email', with: 'ccc'
        fill_in 'Password', with: '2222'
      end
      click_button 'Registrate'
      expect(page).to have_content 'Listing polls'
    end
  end
end
