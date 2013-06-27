class TodosController < ApplicationController
  include SessionsHelper
  before_filter :signed_in_user

  def index
	  todos = current_user.todos
	  respond_to do |format|
		  format.html { render :partial => 'todo', :collection => todos }
		  format.json { render :json => todos }
	  end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

	# make sure the current user owns this todo
	if @todo.user.id != current_user.id
		render :json => { :error => "You don't have access to this item." }
	else
		respond_to do |format|
		  format.html { render :partial => "todo", :locals => { :todo => @todo } }
		  format.json { render json: @todo }
		end
	end
  end

  # POST /todos
  # POST /todos.json
  def create
	params[:todo][:user_id] = current_user.id
    @todo = Todo.new(params[:todo])

    respond_to do |format|
      if @todo.save
        #format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        #format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

	if @todo.user.id != current_user.id
		render :json => { :error => "You don't have access to this item." }
	end

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])

	if @todo.user.id != current_user.id
		render :json => { :error => "You don't have access to this item." }
	end

    @todo.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def signed_in_user
	  render :json => { :error => "Unauthorized" } if current_user.nil?
  end
end
