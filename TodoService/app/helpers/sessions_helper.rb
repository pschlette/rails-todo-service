module SessionsHelper
	require 'bcrypt'

	def current_user=(user)
		@current_user = user
	end

	def current_user
		id = session[:current_user_id]
		@current_user ||= User.find_by_id(id)

		# check for user/pass params passed by API caller
		if @current_user.nil?
			username = params[:username]
			pass = params[:password]
			user = User.find_by_name(username)
			@current_user = user if user && BCrypt::Password.new(user.password) == pass
		end

		return @current_user
	end
end
