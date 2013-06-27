class MainController < ApplicationController
	include SessionsHelper

	def index
		@current_user = current_user
	end
end
