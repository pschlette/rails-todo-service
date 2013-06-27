class SessionsController < ApplicationController
	require 'bcrypt'
	def create
		username = params[:name]
		pass = params[:password]

		@user = User.find_by_name(username)
		if !@user.nil? && BCrypt::Password.new(@user.password) == pass
			session[:current_user_id] = @user.id
			render :json => { :name => @user.name, :id => @user.id }
		else
			session[:current_user_id] = nil
			render :json => { error: "Invalid user/password combination" }
		end
	end

	def destroy
		session[:current_user_id] = nil;
		render :json => { :status => :success }
	end
end
