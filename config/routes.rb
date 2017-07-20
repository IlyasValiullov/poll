Rails.application.routes.draw do
 
	root to: "home#index"
  resources :sessions, only: [:create]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :poll_accesses, only: [:create, :check]
  get "vote" => "poll_accesses#check"

	resources :users

  resources :polls do
    resources :results
  	resources :questions do
  		resources :answers do

  		end
  	end
  end


  # get 'poll_question_answers/new'
  # get 'poll_question_answers/create'
  # get 'poll_question_answers/destroy'
  # get 'poll_question_answers/show'
  # get 'poll_question_answers/index'
  # get 'poll_questions/new'
  # get 'poll_questions/create'
  # get 'poll_questions/destroy'
  # get 'poll_questions/show'
  # get 'poll_questions/index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
