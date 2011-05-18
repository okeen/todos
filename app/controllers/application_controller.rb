class ApplicationController < ActionController::Base
  protect_from_forgery


  protected 
  def current_user
    @user||= session[:user_id].blank? ? nil : User.find(session[:user_id])    
  end
  
  def login_required
    redirect_to(sign_in_path, :notice => "Please log in") and return false if (current_user.blank?)
    logger.debug "current user #{current_user==nil}"
    current_user
    #TODO: some refactoring with User load from session required, move to module (like AuthenticatedSystem)
  end
end
