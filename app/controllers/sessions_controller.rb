class SessionsController < ApplicationController
  # GET /sessions/new
  # GET /sessions/new.xml
  def new
    @session = Session.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session }
    end
  end

  # POST /sessions
  # POST /sessions.xml
  def create
    @user = User.where(params[:user]).first
    
    respond_to do |format|
      if @user and @user.create_session
        session[:user_id] = @user.id
        flash[:notice] = "Welcome #{@user.email}"
        format.html { redirect_to(home_path) }
        format.xml  { render :xml => @session, :status => :created, :location => @session }
      else
        @session = Session.new
        flash[:notice] = "Invalid email/password"
        format.html { render :action => "new" }
        format.xml  { render :xml => @session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    session[:user_id] = null
    respond_to do |format|
      format.html { redirect_to(sessions_url) }
      format.xml  { head :ok }
    end
  end
end
