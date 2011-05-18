class TodoListsController < ApplicationController
  before_filter :logged_in_as_owner_required
  before_filter :load_user_todos
  
  # GET /todos
  # GET /todos.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todo_lists }
      format.json { render :json => @todo_lists}
    end
  end

  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo_list= @todo_lists.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo_list}
      format.json { render :json => @todo_list}
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo_list= @todo_lists.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo_list}
      format.json { render :json => @todo_list}
    end
  end

  # GET /todos/1/edit
  def edit
    @todo_list= @todo_lists.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo_list= @todo_lists.new(params[:todo_list])

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to(user_todo_list_path(@user, @todo_list), :notice => 'Todo List was successfully created.') }
        format.xml  { render :xml => @todo_list, :status => :created, :location => @todo_list}
        format.json { render :json => @todo_list}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo_list.errors, :status => :unprocessable_entity }
        format.json { render :json => @todo_list.errors, :status => :unprocessable_entity}
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo_list= @todo_lists.find(params[:id])

    respond_to do |format|
      if @todo_list.update_attributes(params[:todo_list])
        format.html { redirect_to(user_todo_lists_path(@user), :notice => 'Todo List was successfully updated.') }
        format.xml  { head :ok }
        format.json { render :json => @todo_list}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo_list.errors, :status => :unprocessable_entity }
        format.json { render :json => @todo_list.errors, :status => :unprocessable_entity}
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo_list= @todo_lists.find(params[:id])
    @todo_list.destroy

    respond_to do |format|
      format.html { redirect_to(todos_url) }
      format.xml  { head :ok }
      format.json render :json => {:status => 'ok'}.to_json
    end
  end
  
  private 
  
  def logged_in_as_owner_required
    if current_user.blank? 
      redirect_to(sign_in_path, :notice => "You need to login to manage TODO lists")
    else
      if params[:user_id].to_i != current_user.id
        respond_to do |format|
           format.html { render :text => "<h1>These lists are private</h1>" }
           format.xml  { head :forbidden }
        end
      end
    end
  end
  
  def load_user_todos
    @todo_lists = @user.todo_lists
  end
end
