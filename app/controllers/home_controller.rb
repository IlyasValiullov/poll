class HomeController < ApplicationController 

	def index
		@nickname = current_user != nil ? current_user.email : "noname"
		render "home/index"
	end

end