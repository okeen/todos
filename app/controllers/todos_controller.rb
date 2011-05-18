class TodosController < ApplicationController
  
  before_filter :login_required
  before_filter :load_parent_todo_list_and_children, :except => :search
  
  # GET /todos
  # GET /todos.xml
  # Used as search action for todo items by title
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end

  def search
    @todos = @user.todos.search(params[:q]).paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
    
  end
  
  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo = @todos.find(params[:todo_id])

    respond_to do |format|
      format.html # show.html.erb      
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = @todos.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = @todos.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo = @todos.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to(user_todo_list_path(@todo_list.user, @todo_list)) }
        format.js
      else
        format.html { redirect_to(user_todo_list_path(@todo_list.user, @todo_list)) }
        format.js
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = @todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(todo_list_todo_path(@todo_list, @todo), :notice => 'Todo was successfully updated.') }
        format.js   {render :text => "true"}  
        
      else
        format.html { render :action => "edit" }
        format.js   {render :text => "false"}
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = @todos.find(params[:id])

    respond_to do |format|
      if @todo.destroy
        #FIXME: webrat is not doing an AJAX request, instead it does a normal HTML request, so Selenium needed 
        format.html { redirect_to(user_todo_list_path(@todo_list.user, @todo_list), :notice => "Todo item deleted") }
        format.js   {render :text => "'Todo item deleted'"}
      else
        format.html { redirect_to(user_todo_list_path(@todo_list.user, @todo_list), :notice => "Todo item not deleted") }
        format.js   { render :text => "'Todo item not deleted'",:status => :unprocessable_entity}
      end
    end
  end
  
  private
  
  
  def load_parent_todo_list_and_children
    @todo_list = @user.todo_lists.find(params[:todo_list_id], :include => :todos)
    @todos = @todo_list.todos
  end
  
end
